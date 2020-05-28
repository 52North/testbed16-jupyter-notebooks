#!/bin/bash
cwl-runner \
    --outdir=output/ \
    example/wf_test.cwl \
    example/wf_test_job.yml