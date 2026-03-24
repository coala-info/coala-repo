#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

requirements:
  MultipleInputFeatureRequirement: {}

inputs:
  DT5202: Directory
  DT5203: Directory
  DT5204: Directory
  DT5205: Directory
  DT5206: Directory
  DT5207: Directory
  DT5210: Directory

outputs:
  DT5201:
    type: File[]
    outputSource:
    - SS5201/DT5201
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

steps:
  SS5201:
    in: {}
    run:
      class: Operation
      inputs: {}
      outputs:
        DT5201: File
    out:
    - DT5201
  SS5202:
    in: {}
    run:
      class: Operation
      inputs: {}
      outputs:
        DT5201: File
    out:
    - DT5201
  SS5203:
    in: {}
    run:
      class: Operation
      inputs: {}
      outputs:
        DT5201: File
    out:
    - DT5201
  SS5204:
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
    - DT5201
    - DT5202
  SS5205:
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
    - DT5201
    - DT5203
  SS5206:
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
    - DT5201
    - DT5204
  SS5207:
    in: {}
    run:
      class: Operation
      inputs: {}
      outputs:
        DT5201: File
    out:
    - DT5201
  SS5208:
    in: {}
    run:
      class: Operation
      inputs: {}
      outputs:
        DT5201: File
    out:
    - DT5201
  SS5209:
    in: {}
    run:
      class: Operation
      inputs: {}
      outputs:
        DT5201: File
        DT5205: Directory
    out:
    - DT5201
    - DT5205
  SS5210:
    in: {}
    run:
      class: Operation
      inputs: {}
      outputs:
        DT5201: File
        DT5206: Directory
    out:
    - DT5201
    - DT5206
  SS5211:
    in: {}
    run:
      class: Operation
      inputs: {}
      outputs:
        DT5201: File
        DT5207: Directory
    out:
    - DT5201
    - DT5207
  SS5212:
    in:
      DT5205: SS5209/DT5205
      DT5206: SS5210/DT5206
      DT5207: SS5211/DT5207
    run:
      class: Operation
      inputs:
        DT5205: Directory
        DT5206: Directory
        DT5207: Directory
      outputs:
        DT5201: File
        DT52011: Directory
    out:
    - DT5201
    - DT52011
  SS5213:
    in:
      DT52011: SS5212/DT52011
      DT5202: SS5204/DT5202
      DT5203: SS5205/DT5203
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT52011: Directory
        DT5202: Directory
        DT5203: Directory
        DT5210: Directory
      outputs:
        DT5201: File
        DT5208: Directory
    out:
    - DT5201
    - DT5208
  SS5214:
    in:
      DT5204: SS5206/DT5204
      DT5208: SS5213/DT5208
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5204: Directory
        DT5208: Directory
        DT5210: Directory
      outputs:
        DT5201: File
        DT5209: Directory
    out:
    - DT5201
    - DT5209
  SS5215:
    in:
      DT5208: SS5213/DT5208
      DT5209: SS5214/DT5209
      DT5210: DT5210
    run:
      class: Operation
      inputs:
        DT5208: Directory
        DT5209: Directory
        DT5210: Directory
      outputs:
        DT5201: File
    out:
    - DT5201
