#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}

inputs:
  DT7403:
    doc: "Waveforms data, GPS offsets, fault geometry, velocity model, points source characteristics for kinematic inversion."
    type: Directory

outputs:
  DT7404:
    doc: "Kinematic rupture model."
    type: Directory
    outputSource: ST740203/DT7404
  DT7405:
    doc: "Dynamic rupture model."
    type: Directory
    outputSource: ST740205/DT7405

steps:
  ST740201:
    doc: "Prepare kinematic inversion data."
    in:
      InputData: DT7403
    run:
      class: Operation
      inputs:
        InputData: Directory
      outputs:
        PreparedKinematicData: Directory
    out:
      - PreparedKinematicData

  ST740202:
    doc: "Run kinematic source inversion using HPC."
    in:
      PreparedKinematicData: ST740201/PreparedKinematicData
    run:
      class: Workflow
      inputs:
        PreparedKinematicData: Directory
      outputs:
        KinematicResult: Directory
      steps:
        SS7403:
          doc: "SLIPNEAR: Kinematic inversion solver"
          in:
            PreparedKinematicData: PreparedKinematicData
          run:
            class: Operation
            inputs:
              PreparedKinematicData: Directory
            outputs:
              KinematicResult: Directory
          out:
            - KinematicResult
    out:
      - KinematicResult

  ST740203:
    doc: "Generate kinematic rupture model."
    in:
      KinematicResult: ST740202/KinematicResult
    run:
      class: Operation
      inputs:
        KinematicResult: Directory
      outputs:
        DT7404: Directory
    out:
      - DT7404

  ST740204:
    doc: "Run kinematically informed dynamic rupture simulation using HPC."
    in:
      KinematicInversionResult: ST740203/DT7404
    run:
      class: Workflow
      inputs:
         KinematicInversionResult: Directory
      outputs:
        DynamicRuptureResult: Directory
      steps:
        SS7401:
          doc: "SeisSol: Dynamic rupture simulation on HPC."
          in:
            KinematicInversionResult: KinematicInversionResult
          run:
            class: Operation
            inputs:
              KinematicInversionResult: Directory
            outputs:
              DynamicRuptureResult: Directory
          out:
            - DynamicRuptureResult
    out:
      - DynamicRuptureResult 

  ST740205:
    doc: "Kinematically-informed dynamic rupture model."
    in:
      DynamicRuptureResult: ST740204/DynamicRuptureResult
    run:
      class: Operation
      inputs:
        DynamicRuptureResult: Directory
      outputs:
        DT7405: Directory
    out:
      - DT7405