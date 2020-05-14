#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: papermill

inputs: 
  nb2_input_notebook:
    type: File
    inputBinding:
      position: 1
  nb2_output_notebook:
    default: output.ipynb
    type: string
    inputBinding:
      position: 2
      separate: true
      shellQuote: true
    streamable: false
  sentinel_ids:
    default: sentinel_ids
    type: string
    inputBinding:
      position: 3 
      prefix: -p
      separate: true
      shellQuote: true
    streamable: false
  parameters:
    type: string
    inputBinding:
      position: 4
      shellQuote: true
    streamable: false

outputs: 
  output_notebook:
    outputBinding:
      glob: $(inputs.nb2_output_notebook)
    streamable: false
    type: File
  floodmask:
    outputBinding:
      glob: result.tif
    streamable: false
    type: File
