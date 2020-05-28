#!/bin/bash
cwl-runner  \
    --preserve-entire-environment \
    --no-read-only \
    --no-match-user \
    --outdir ./outputs/ \
    workflow.cwl workflow_job.yml