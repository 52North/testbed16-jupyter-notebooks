#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: papermill
hints:
  DockerRequirement:
    dockerPull: papermill:latest
inputs: 
  input_notebook:
    type: File
    inputBinding:
      position: 1
  output_notebook:
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
      glob: $(inputs.output_notebook)
    streamable: false
    type: File
