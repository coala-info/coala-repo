#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

inputs:
  dir:
    type: Directory
      class: Directory
      location: test_dir

outputs:
  newdir:
    type: Directory
    outputSource: dir

steps: []
