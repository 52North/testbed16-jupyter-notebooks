#!/bin/bash
cwl-runner \
    --outdir=output/ \
    example_docker/wf_test.cwl \
    example_docker/wf_test_job.yml