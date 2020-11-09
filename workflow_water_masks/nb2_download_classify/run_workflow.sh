#!/bin/bash
cwl-runner \
    --outdir=output/ \
    --no-read-only \
    --no-match-user \
    example_docker/wf_test.cwl \
    example_docker/wf_test_job.yml