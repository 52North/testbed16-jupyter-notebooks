#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
inputs:
  nb2_input_notebook: File
  nb2_output_notebook: string
  parameters: 
    type: 
      type: array
      items: string

outputs: 
  nb2_output_notebook:
    type: 
      type: array
      items: File
    streamable: false
    outputSource: nb2_execute/output_notebook

requirements:
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}

steps:
  nb2_execute:
    run: ../nb2.cwl
    scatter: parameters
    in:
      nb2_input_notebook: nb2_input_notebook
      nb2_output_notebook: nb2_output_notebook
      parameters: parameters
    out: [output_notebook, floodmask]
