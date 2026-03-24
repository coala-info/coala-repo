#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

inputs:
  DT6112: Directory

outputs:
  DT6113:
    type: Directory
    outputSource: SS6116/DT6113

steps:
  SS6115:
    in:
      DT6112: DT6112
    run:
      class: Operation
      inputs:
        DT6112: Directory
      outputs:
        alert_levels: Directory
    out:
    - alert_levels
  SS6116:
    in:
      DT6112: DT6112
      alert_levels: SS6115/alert_levels
    run:
      class: Operation
      inputs:
        DT6112: Directory
        alert_levels: Directory
      outputs:
        DT6113: Directory
    out:
    - DT6113
