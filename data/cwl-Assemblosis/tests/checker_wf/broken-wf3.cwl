#!/usr/bin/env cwl-runner
class: Workflow
cwlVersion: v1.0
requirements:
  ScatterFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  StepInputExpressionRequirement: {}
inputs:
  letters0:
    type: [string, int]
  letters1:
    type: string[]
  letters2:
    type: [string, int]
  letters3:
    type: string[]
  letters4:
    type: string
  letters5:
    type: string[]

outputs:
  all:
    type: File
    outputSource: cat/txt

steps:
  - id: embedded
    run: functional-wf.cwl
    in: []
    out:
     - id: All
  - id: cat
    run: cat.cwl
    in:
      - id: cat_in
        source:
         - embedded/All
    out: [txt]
