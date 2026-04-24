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
    type: int
  letters5:
    type: string[]

outputs:
  all:
    type: File[]
    outputSource: cat/txt

steps:
  echo_v:
    run: echo.cwl
    in: {}
    out: [txt]
  echo_w:
    run: echo.cwl
    in:
      echo_in: letters0
    out: [txt, other]
  echo_x:
    run: echo.cwl
    scatter: echo_in
    in:
      echo_in:
        source: [letters1, letters2]
        linkMerge: merge_nested
    out: [txt]
  echo_y:
    run: echo.cwl
    scatter: echo_in
    in:
      echo_in:
        source: [letters3, letters4]
        linkMerge: merge_flattened
    out: [txt]
  echo_z:
    run: echo.cwl
    in:
      echo_in:
        source: letters5
        valueFrom: "special value parsed in valueFrom"
    out: [txt]
  cat:
    run: cat.cwl
    in:
      cat_in:
        source: [echo_w/txt, echo_x/txt, echo_y/txt, echo_z/txt, letters0]
        linkMerge: merge_flattened
    out: [txt]
