#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
inputs:
  nb3_input_notebook: File
  nb3_output_notebook: string
  floodmasks_geotiff: 
    type: 
      type: array
      items: File

outputs: 
  nb3_output_notebook:
    type: File
    streamable: false
    outputSource: nb3_execute/output_notebook
  nb3_floodmask:
    type: File
    streamable: false
    outputSource: nb3_execute/floodmask

requirements:
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}

steps:
  nb3_execute:
    run: ../nb3.cwl
    in:
      nb3_input_notebook: nb3_input_notebook
      nb3_output_notebook: nb3_output_notebook
      floodmasks_geotiff: floodmasks_geotiff
    out: [output_notebook, floodmask]
