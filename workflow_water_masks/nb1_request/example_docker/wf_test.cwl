#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
inputs:
  areaOfInterest: string
outputs:
  files:
    type: 
      type: array
      items: string
    streamable: false
    outputSource: parse/files
steps:
  execute:
    in:
      areaOfInterest: areaOfInterest
    out: [standard_output]
    run:
      class: CommandLineTool
      baseCommand: papermill
      hints:
        DockerRequirement:
          dockerPull: workflow_water_masks_nb1request:latest
      requirements:
        EnvVarRequirement:
          envDef:
            SCIHUB_UN: xyz
            SCIHUB_PW: xyz

      inputs:
        areaOfInterest:
          type: string
      arguments: ["/nb1.ipynb", "out.ipynb", "-p", "REQUEST_AREA", $(inputs.areaOfInterest)]

      outputs:
        standard_output:
          type: File
          outputBinding:
            glob: out.ipynb

  parse:
    in: 
      input_nb: execute/standard_output
    out: [files]
    run:
      class: CommandLineTool
      hints:
        DockerRequirement:
          dockerPull: workflow_water_masks_nb1request:latest
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
        files:
          type:
            type: array
            items: string
          outputBinding:
            glob: csvItems
            loadContents: true
            outputEval: $(self[0].contents.replace('\n','').split(','))