#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
inputs:
  floodmasks_geotiff: 
    type: 
      type: array
      items: File

outputs: 
  floodmask_mosaic:
    type: File
    streamable: false
    outputSource: execute/floodmask_mosaic

requirements:
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}
  EnvVarRequirement:
    envDef:
      LC_ALL: en_US.UTF-8
      LANG: en_US.UTF-8

steps:
  execute:
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
      floodmasks_geotiff_as_array: floodmasks_geotiff
    out: [floodmask_mosaic]
