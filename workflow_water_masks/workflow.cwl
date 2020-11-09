#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
requirements:
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}
  ResourceRequirement:
    ramMin: 4000
    ramMax: 12000
  EnvVarRequirement:
    envDef:
      SCIHUB_UN: xyz
      SCIHUB_PW: abc
inputs:
  areaOfInterest: string
  startDate: string
  endDate: string
outputs: 
  floodmask_mosaic:
    type: File
    streamable: false
    outputSource: mosaic/floodmask_mosaic
steps:
  discover:
    in:
      areaOfInterest: areaOfInterest
      startDate: startDate
      endDate: endDate
    out: [nb1_out]
    run:
      class: CommandLineTool
      baseCommand: papermill
      hints:
        DockerRequirement:
          dockerPull: 52north/testbed16-wwm-discover:latest

      inputs:
        areaOfInterest:
          type: string
        startDate:
          type: string
        endDate:
          type: string
      arguments: ["/nb1.ipynb", "out.ipynb", "-p", "REQUEST_AREA", $(inputs.areaOfInterest),
          "-p", "START_DATE", $(inputs.startDate), "-p", "END_DATE", $(inputs.endDate)]

      outputs:
        nb1_out:
          type: File
          outputBinding:
            glob: out.ipynb

  discover_parse:
    in: 
      input_nb: discover/nb1_out
    out: [sentinelIds]
    run:
      class: CommandLineTool
      hints:
        DockerRequirement:
          dockerPull: 52north/testbed16-wwm-classify:latest
      baseCommand: ["python3", "parse.py"]
      requirements:
        InlineJavascriptRequirement: {}
        InitialWorkDirRequirement:
          listing:
            - entryname: parse.py
              entry: |
                import scrapbook as sb
                nb = sb.read_notebook("$(inputs.input_nb.path)")
                print(','.join(list(nb.scrap_dataframe["data"])[0]))

      stdout: csvItems

      inputs: 
        input_nb:
          type: File

      outputs: 
        sentinelIds:
          type:
            type: array
            items: string
          outputBinding:
            glob: csvItems
            loadContents: true
            outputEval: $(self[0].contents.replace('\n','').split(','))

  classify:
    run:
      class: CommandLineTool
      baseCommand: papermill

      hints:
        DockerRequirement:
          dockerPull: 52north/testbed16-wwm-mosaic:latest

      requirements:
        ResourceRequirement:
          ramMin: 4000
          ramMax: 12000

      arguments: ["/nb2.ipynb", "out.ipynb", "-p", "sentinel_ids", $(inputs.sentinelSceneIds),
            "-p", "REQUEST_AREA", $(inputs.areaOfInterest)]

      inputs: 
        sentinelSceneIds:
          type: string
        areaOfInterest:
          type: string

      outputs: 
        floodmask:
          outputBinding:
            glob: result.tif
          streamable: false
          type: File

    scatter: sentinelSceneIds
    in:
      sentinelSceneIds: discover_parse/sentinelIds
      areaOfInterest: areaOfInterest
    out: [floodmask]

  mosaic:
    run:
      class: CommandLineTool
      baseCommand: papermill

      requirements: 
        InlineJavascriptRequirement: {}

      hints:
        DockerRequirement:
          dockerPull: workflow_water_masks_nb3aggregate:latest

      arguments: ["/nb3.ipynb", "out.ipynb"]

      inputs: 
        floodmasks_geotiff_as_array:
          type: 
            type: array
            items: File
          inputBinding:
            prefix: -y
            valueFrom: |
              ${
                var yml = "floodmasks_geotiff: ["
                self.forEach(function(file){
                  yml = yml + file.path + ","
                })
                yml = yml + "]"
                return yml
              }
          streamable: false

      outputs: 
        floodmask_mosaic:
          outputBinding:
            glob: mosaic.tif
          streamable: false
          type: File

    in:
      floodmasks_geotiff_as_array: classify/floodmask
    out: [floodmask_mosaic]
