#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

inputs:
  DT6102:
    doc: NEAMTHM18
    type: Directory
  DT6106:
    doc: list-of-earthquake-scenarios
    type: Directory
  DT6108:
    doc: list-of-landslide-scenarios
    type: Directory
  DT6109:
    doc: topo-bathymetric-grids
    type: Directory

outputs:
  DT6110:
    doc: Tsunami-intensities
    type: Directory
    outputSource: SS6107/DT6110
  DT6111:
    doc: Ground-deformation
    type: Directory
    outputSource: SS6107/DT6111

steps:
  SS6106:
    doc: SeisSol
    in:
      DT6106: DT6106
      DT6109: DT6109
    run:
      class: Operation
      inputs:
        DT6106: Directory
        DT6109: Directory
      outputs:
        dynamic-deformation: Directory
    out:
    - dynamic-deformation
  SS6107:
    doc: Tsunami-HySEA
    in:
      DT6106: DT6106
      DT6109: DT6109
    run:
      class: Operation
      inputs:
        DT6106: Directory
        DT6109: Directory
      outputs:
        DT6110: Directory
        DT6111: Directory
        offshore-time-series: Directory
    out:
    - DT6110
    - DT6111
    - offshore-time-series
  SS6108:
    doc: Landslide-HySEA
    in:
      DT6108: DT6108
      DT6109: DT6109
    run:
      class: Operation
      inputs:
        DT6108: Directory
        DT6109: Directory
      outputs:
        dynamic-landslide-deformation: Directory
    out:
    - dynamic-landslide-deformation
  SS6109:
    doc: BingClaw
    in:
      DT6108: DT6108
      DT6109: DT6109
    run:
      class: Operation
      inputs:
        DT6108: Directory
        DT6109: Directory
      outputs:
        dynamic-landslide-deformation 1: Directory
    out:
    - dynamic-landslide-deformation 1
  SS6110:
    doc: SHALTOP
    in:
      DT6108: DT6108
      DT6109: DT6109
    run:
      class: Operation
      inputs:
        DT6108: Directory
        DT6109: Directory
      outputs:
        dynamic-landslide-deformation 2: Directory
    out:
    - dynamic-landslide-deformation 2
  SS6111:
    doc: InundationAI
    in:
      offshore-time-series: SS6107/offshore-time-series
    run:
      class: Operation
      inputs:
        offshore-time-series: Directory
      outputs:
        2D-inundation-pattern: Directory
    out:
    - 2D-inundation-pattern
  SS6112:
    doc: Source-to-wave-filter
    in:
      dynamic-deformation: SS6106/dynamic-deformation
      dynamic-landslide-deformation 1: SS6109/dynamic-landslide-deformation 1
      dynamic-landslide-deformation 2: SS6110/dynamic-landslide-deformation 2
    run:
      class: Operation
      inputs:
        dynamic-deformation: Directory
        dynamic-landslide-deformation 1: Directory
        dynamic-landslide-deformation 2: Directory
      outputs:
        dynamic-deformation: Directory
        dynamic-landslide-deformation: Directory
    out:
    - dynamic-deformation
    - dynamic-landslide-deformation
  SS6119:
    doc: Retrieving-of-precomputed-simulations
    in:
      DT6102: DT6102
    run:
      class: Operation
      inputs:
        DT6102: Directory
      outputs:
        DT6110: Directory
    out:
    - DT6110
