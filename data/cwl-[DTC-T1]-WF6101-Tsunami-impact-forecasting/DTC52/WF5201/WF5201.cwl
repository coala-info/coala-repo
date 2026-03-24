#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

requirements:
  MultipleInputFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}

inputs:
  DT5210: Directory

outputs:
  DT5201:
    type: File[]
    outputSource:
    - ST520101/DT5201
    - SS5202/DT5201
    - SS5203/DT5201
    - SS5204/DT5201
    - SS5205/DT5201
    - SS5206/DT5201
    - SS5207/DT5201
    - SS5208/DT5201
    - SS5209/DT5201
    - SS5210/DT5201
    - SS5211/DT5201
    - SS5212/DT5201
    - SS5213/DT5201
    - SS5214/DT5201
    - SS5215/DT5201
    linkMerge: merge_flattened
  DT5202:
    type: Directory
    outputSource: SS5204/DT5202
  DT5203:
    type: Directory
    outputSource: SS5205/DT5203
  DT5204:
    type: Directory
    outputSource: SS5206/DT5204
  DT5205:
    type: Directory
    outputSource: SS5209/DT5205
  DT5206:
    type: Directory
    outputSource: SS5210/DT5206
  DT5207:
    type: Directory
    outputSource: SS5211/DT5207
  DT5208:
    type: Directory
    outputSource: SS5213/DT5208
  DT5209:
    type: Directory[]
    outputSource:
    - SS5215/DT5209
    - SS5214/DT5209
    linkMerge: merge_flattened

steps:
  ST520101:
    in:
      DT5202: SS5204/DT5202
      DT5203: SS5205/DT5203
      DT5204: SS5206/DT5204
      DT5205: SS5209/DT5205
      DT5206: SS5210/DT5206
      DT5207: SS5211/DT5207
      DT5210: DT5210
    run: ST520101.cwl
    out:
    - DT5201
  SS5202:
    doc: ST520102
    in:
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5210: Directory
      outputs:
        DT5201: File
    out:
    - DT5201
  SS5203:
    doc: ST520103
    in:
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5210: Directory
      outputs:
        DT5201: File
    out:
    - DT5201
  SS5204:
    doc: ST520104
    in:
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5210: Directory
      outputs:
        DT5201: File
        DT5202: Directory
    out:
    - DT5202
    - DT5201
  SS5205:
    doc: ST520105
    in:
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5210: Directory
      outputs:
        DT5201: File
        DT5203: Directory
    out:
    - DT5203
    - DT5201
  SS5206:
    doc: ST520106
    in:
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5210: Directory
      outputs:
        DT5201: File
        DT5204: Directory
    out:
    - DT5204
    - DT5201
  SS5207:
    doc: ST520107
    in:
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5210: Directory
      outputs:
        DT5201: File
    out:
    - DT5201
  SS5208:
    doc: ST520108
    in:
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5210: Directory
      outputs:
        DT5201: File
    out:
    - DT5201
  SS5209:
    doc: ST520109
    in:
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5210: Directory
      outputs:
        DT5201: File
        DT5205: Directory
    out:
    - DT5205
    - DT5201
  SS5210:
    doc: ST520110
    in:
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5210: Directory
      outputs:
        DT5201: File
        DT5206: Directory
    out:
    - DT5206
    - DT5201
  SS5211:
    doc: ST520111
    in:
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5210: Directory
      outputs:
        DT5201: File
        DT5207: Directory
    out:
    - DT5207
    - DT5201
  SS5212:
    doc: ST520112
    in:
      DT5205: SS5209/DT5205
      DT5206: SS5210/DT5206
      DT5207: SS5211/DT5207
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5205: Directory
        DT5206: Directory
        DT5207: Directory
        DT5210: Directory
      outputs:
        DT5201: File
    out:
    - DT5201
  SS5213:
    doc: ST520113
    in:
      DT5202: SS5204/DT5202
      DT5203: SS5205/DT5203
      DT5204: SS5206/DT5204
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5202: Directory
        DT5203: Directory
        DT5204: Directory
        DT5210: Directory
      outputs:
        DT5201: File
        DT5208: Directory
    out:
    - DT5208
    - DT5201
  SS5214:
    doc: ST520114
    in:
      DT5208: SS5213/DT5208
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5208: Directory
        DT5210: Directory
      outputs:
        DT5201: File
        DT5209: Directory
    out:
    - DT5209
    - DT5201
  SS5215:
    doc: ST520115
    in:
      DT5208: SS5213/DT5208
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5208: Directory
        DT5210: Directory
      outputs:
        DT5201: File
        DT5209: Directory
    out:
    - DT5201
    - DT5209
