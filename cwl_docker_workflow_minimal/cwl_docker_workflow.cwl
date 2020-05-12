#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
inputs:
  nb1_input_notebook: File
  nb1_output_notebook: string
  nb2_input_notebook: File
  nb2_output_notebook: string
  parameters: File

outputs: 
  first_output:
    type: File
    streamable: false
    outputSource: nb1_execute/output_0
  second_output:
    type: File
    streamable: false
    outputSource: nb2_execute/output_0

steps:
  nb1_execute:
    run: cwl_notebook_1.cwl
    in:
      nb1_input_notebook: nb1_input_notebook
      nb1_output_notebook: nb1_output_notebook
      parameters: parameters
    out: [output_0]

  nb2_execute:
    run: cwl_notebook_2.cwl
    in:
      nb2_input_notebook: nb2_input_notebook
      nb2_output_notebook: nb2_output_notebook
      some_parameter: nb1_execute/output_0
    out: [output_0]





