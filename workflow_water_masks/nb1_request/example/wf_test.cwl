#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
inputs:
  nb1_input_notebook: File
  nb1_output_notebook: string
  parameters: File

outputs: 
  nb1_output_notebook:
    type: File
    streamable: false
    outputSource: nb1_execute/output_0

requirements:
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}

steps:
  nb1_execute:
    run: ../nb1.cwl
    in:
      nb1_input_notebook: nb1_input_notebook
      nb1_output_notebook: nb1_output_notebook
      parameters: parameters
    out: [output_0]
