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
    type: string
    inputBinding:
      position: 2
      separate: true
      shellQuote: true
    streamable: false
  some_para: 
    type: string
    default: input_path
    inputBinding:
      position: 3
      prefix: -p
      separate: true
      shellQuote: true
    streamable: false
  some_parameter: 
    type: File
    inputBinding:
      position: 4
    streamable: false    

outputs: 
  output_0:
    outputBinding:
      glob: $(inputs.nb2_output_notebook)
    streamable: false
    type: File
