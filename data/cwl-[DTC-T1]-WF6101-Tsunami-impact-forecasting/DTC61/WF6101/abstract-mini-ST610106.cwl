#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

inputs:
  DT6102:
    doc: NEAMTHM18
    type: Directory
  DT6106:
    doc: list of earthquake scenarios
    type: Directory
  DT6109:
    doc: topo-bathymetric grids
    type: Directory

outputs:
  DT6110:
    doc: Tsunami intensities
    type: Directory
    outputSource: SS6107/DT6110

steps:
  SS6107:
    doc: Tsunami-HySEA
    in:
      DT6102: DT6102
      DT6106: DT6106
      DT6109: DT6109
    run:
      class: Operation
      inputs:
        DT6102: Directory
        DT6106: Directory
        DT6109: Directory
      outputs:
        DT6110: Directory
    out:
    - DT6110
