#!/bin/bash
cwl-runner \
    --outdir=output/ \
    --no-read-only \
    --no-match-user \
    example/wf_test.cwl \
    example/wf_test_job.yml