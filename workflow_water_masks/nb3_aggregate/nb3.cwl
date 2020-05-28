#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: papermill

requirements: 
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerPull: workflow_water_masks_nb3aggregate:latest

inputs: 
  nb3_input_notebook:
    type: File
    inputBinding:
      position: 1
  nb3_output_notebook:
    default: nb3_output.ipynb
    type: string
    inputBinding:
      position: 2
      separate: true
      shellQuote: true
    streamable: false
  floodmasks_geotiff:
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
  output_notebook:
    outputBinding:
      glob: $(inputs.nb3_output_notebook)
    streamable: false 
    type: File
  floodmask:
    outputBinding:
      glob: mosaic.tif
    streamable: false
    type: File
