#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}

# Define global inputs
inputs:
  DT7105:
    doc: "Input files for computing the 2020 European Seismic Risk Model (ESRM20)."
    type: Directory
  DT7108:
    doc: "Updated Seismogenic Source Model."
    type: File

# Define global outputs
outputs:
  DT7110:
    doc: "Seismic Risk Results: Loss Maps, Loss Curves"
    type: Directory

steps:
  ST710401:
    doc: "E1: Get OQ Input Files"
    in:
      DT7105: DT7105
    run:
      class: Operation
      inputs:
        DT7105: Directory
      outputs:
        OQ_Risk_Input_Bundle: File
    out:
      - OQ_Risk_Input_Bundle

  ST710402:
    doc: "Risk Calculation (OpenQuake)"
    in:
      OQ_Risk_Input_Bundle: ST710401/OQ_Risk_Input_Bundle
    run:
      class: Workflow
      inputs:
        OQ_Risk_Input_Bundle:
          type: File
          doc: "Input bundle for OpenQuake risk calculation"
      outputs:
        Risk_Calculation_Result:
          type: File
          doc: "Result of the risk calculation"
      steps:
        SS7102:
          doc: "The OpenQuake Engine computes seismic hazard and risk."
          in:
            OQ_Risk_Input_Bundle: OQ_Risk_Input_Bundle
          run:
            class: Operation
            inputs:
              OQ_Risk_Input_Bundle: File
            outputs:
              Risk_Calculation_Result: File
          out:
            - Risk_Calculation_Result
    out:
      - Risk_Calculation_Result

  ST710403:
    doc: "E3: Risk Output – Risk Maps, Risk Curves, etc."
    in:
      Risk_Calculation_Result: ST710402/Risk_Calculation_Result
    run:
      class: Operation
      inputs:
        Risk_Calculation_Result: File
      outputs:
        DT7110: Directory
    out:
      - DT7110
