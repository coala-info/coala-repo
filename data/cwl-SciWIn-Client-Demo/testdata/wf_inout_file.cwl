#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

inputs:
  file:
    type: File
      class: File
      location: file.txt

outputs:
  newfile:
    type: File
    outputSource: file

steps: []
