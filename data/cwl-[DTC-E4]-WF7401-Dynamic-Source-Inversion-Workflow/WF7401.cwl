#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}

inputs:
  DT7401:
    doc: "Fault geometry, velocity model, waveforms data or geodetic data for dynamic inversion."
    type: Directory

outputs:
  DT7402:
    doc: "Data-driven dynamic rupture model."
    type: Directory
    outputSource: ST740103/DT7402

steps:
  ST740101:
    doc: "Prepare dynamic inversion data."
    in:
      InputData: DT7401
    run:
      class: Operation
      inputs:
        InputData: Directory
      outputs:
        PreparedData: File
    out:
      - PreparedData

  ST740102:
    doc: "Perform dynamic source inversion using HPC."
    in:
      PreparedData: ST740101/PreparedData
    run:
      class: Workflow
      inputs:
        PreparedData: File
      outputs:
        InversionResult: File
      steps:
        SS7402:
          doc: "FFSINV: Dynamic inversion with HPC solver"
          in:
            PreparedData: PreparedData
          run:
            class: Operation
            inputs:
              PreparedData: File
            outputs:
              InversionResult: File
          out:
            - InversionResult
    out:
      - InversionResult

  ST740103:
    doc: "Generate data-driven dynamic rupture model."
    in:
      InversionResult: ST740102/InversionResult
    run:
      class: Operation
      inputs:
        InversionResult: File
      outputs:
        DT7402: Directory
    out:
      - DT7402