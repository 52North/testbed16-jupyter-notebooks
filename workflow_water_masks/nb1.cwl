#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: papermill

inputs: 
  nb1_input_notebook:
    type: File
    inputBinding:
      position: 1
  nb1_output_notebook:
    default: output.ipynb
    type: string
    inputBinding:
      position: 2
      separate: true
      shellQuote: true
    streamable: false
  parameters:
    type: File
    inputBinding:
      position: 3
      prefix: -f

outputs: 
  output_0:
    outputBinding:
      glob: $(inputs.nb1_output_notebook)
    streamable: false
    type: File
