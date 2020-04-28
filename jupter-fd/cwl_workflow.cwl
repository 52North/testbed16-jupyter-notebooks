#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: papermill
inputs: 
  input_file:
    type: string
    inputBinding:
      position: 1
  output_file:
    type: string
    inputBinding:
      position: 2
  parameters:
    type: File
    inputBinding:
      position: 3
      prefix: -f

outputs: []