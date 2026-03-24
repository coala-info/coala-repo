#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}

inputs:
  DT6102:
    doc: NEAMTHM18
    type: Directory
  DT6103:
    doc: EIDA seismic data archive
    type: Directory
  DT6104:
    doc: SLSMF sea level data
    type: Directory
  DT6105:
    doc: GNSS displacements
    type: Directory
  DT6109:
    doc: topo-bathymetric grids
    type: Directory

outputs:
  DT6101:
    doc: Scenario Library
    type: Directory
    outputSource: ST610101/DT6101
  DT6106:
    doc: list of earthquake scenarios
    type: Directory
    outputSource: ST610105/DT6106
  DT6107:
    doc: list of scenario probabilities
    type: Directory
    outputSource: ST610105/DT6107
  DT6108:
    doc: list of landslide scenarios
    type: Directory
    outputSource: ST610110/DT6108
  DT6110:
    doc: Tsunami intensities
    type: Directory
    outputSource: ST610106/DT6110
  DT6111:
    doc: Ground deformation
    type: Directory
    outputSource: ST610106/DT6111
  DT6112:
    doc: Tsunami hazard curves
    type: Directory
    outputSource: ST610108/DT6112
  DT6113:
    doc: Hazard visual products
    type: Directory
    outputSource: ST610109/DT6113

steps:
  ST610101:
    doc: SS6101
    in:
      DT6103: DT6103
      DT6104: DT6104
      DT6105: DT6105
    run:
      class: Operation
      inputs:
        DT6103: Directory
        DT6104: Directory
        DT6105: Directory
      outputs:
        DT6101: Directory
    out:
    - DT6101
  ST610102:
    doc: SS6102
    in:
      DT6101: ST610101/DT6101
    run:
      class: Operation
      inputs:
        DT6101: Directory
      outputs:
        event_file: File
    out:
    - event_file
  ST610103:
    doc: SS6103
    in:
      DT6101: ST610101/DT6101
    run:
      class: Operation
      inputs:
        DT6101: Directory
      outputs:
        sea_level_data: Directory
    out:
    - sea_level_data
  ST610104:
    doc: SS6104
    in:
      DT6101: ST610101/DT6101
    run:
      class: Operation
      inputs:
        DT6101: Directory
      outputs:
        gnss_data: Directory
    out:
    - gnss_data
  ST610105:
    doc: SS6105
    in:
      DT6102: DT6102
      event_file: ST610102/event_file
    run:
      class: Operation
      inputs:
        DT6102: Directory
        event_file: File
      outputs:
        DT6106: Directory
        DT6107: Directory
    out:
    - DT6106
    - DT6107
  ST610106:
    in:
      DT6102: DT6102
      DT6106: ST610105/DT6106
      DT6108: ST610110/DT6108
      DT6109: DT6109
    run: ST610106.cwl
    out:
    - DT6110
    - DT6111
  ST610107:
    doc: SS6113
    in:
      DT6110: ST610106/DT6110
      DT6111: ST610106/DT6111
      gnss_data: ST610104/gnss_data
      sea_level_data: ST610103/sea_level_data
    run:
      class: Operation
      inputs:
        DT6110: Directory
        DT6111: Directory
        gnss_data: Directory
        sea_level_data: Directory
      outputs:
        misfit_output: Directory
    out:
    - misfit_output
  ST610108:
    doc: SS6114
    in:
      DT6107: ST610105/DT6107
      DT6110: ST610106/DT6110
      misfit_output: ST610107/misfit_output
    run:
      class: Operation
      inputs:
        DT6107: Directory
        DT6110: Directory
        misfit_output: Directory
      outputs:
        DT6112: Directory
    out:
    - DT6112
  ST610109:
    in:
      DT6112: ST610108/DT6112
    run: ST610109.cwl
    out:
    - DT6113
  ST610110:
    doc: SS6117
    in:
      shakemaps: ST610111/shakemaps
    run:
      class: Operation
      inputs:
        shakemaps: Directory
      outputs:
        DT6108: Directory
    out:
    - DT6108
  ST610111:
    doc: SS6118
    in:
      gnss_data: ST610104/gnss_data
    run:
      class: Operation
      inputs:
        gnss_data: Directory
      outputs:
        shakemaps: Directory
    out:
    - shakemaps
