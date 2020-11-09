#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
requirements:
  SubworkflowFeatureRequirement: {}
  ScatterFeatureRequirement: {}
inputs:
  sentinelSceneIds: 
    type: 
      type: array
      items: string
  areaOfInterest: string
outputs:
  classifiedScenes:
    type: 
      type: array
      items: File
    streamable: false
    outputSource: execute/floodmask
steps:
  execute:
    run:
      class: CommandLineTool
      baseCommand: papermill

      hints:
        DockerRequirement:
          dockerPull: workflow_water_masks_nb2classify:latest

      requirements:
        EnvVarRequirement:
          envDef:
            SCIHUB_UN: xyz
            SCIHUB_PW: abc
        ResourceRequirement:
          ramMin: 4000
          ramMax: 12000

      arguments: ["/nb2.ipynb", "out.ipynb", "-p", "sentinel_ids", $(inputs.sentinelSceneIds),
            "-p", "REQUEST_AREA", $(inputs.areaOfInterest)]

      inputs: 
        sentinelSceneIds:
          type: string
        areaOfInterest:
          type: string

      outputs: 
        floodmask:
          outputBinding:
            glob: result.tif
          streamable: false
          type: File

    scatter: sentinelSceneIds
    in:
      sentinelSceneIds: sentinelSceneIds
      areaOfInterest: areaOfInterest
    out: [floodmask]
