#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}

# Define global inputs
inputs:
  DT7104:
    doc: "Input files for computing the 2020 European Seismic Hazard Model (ESHM20)."
    type: Directory
  DT7108:
    doc: "Updated Seismogenic Source Model."
    type: File

# Define global outputs
outputs:
  DT7109:
    doc: "Seismic Hazard Results: Maps, Curves, Uniform Hazard Spectra."
    type: Directory

steps:
  ST710301:
    doc: "Get OQ Input Hazard Files"
    in:
       DT7104:  DT7104
    run:
      class: Operation
      inputs:
        DT7104: Directory
      outputs:
        OQ_Input_Bundle: File
    out:
      - OQ_Input_Bundle

  ST710302:
    doc: "Hazard Calculation (OpenQuake)"
    in:
      OQ_Input_Bundle: ST710301/OQ_Input_Bundle
    run:
      class: Workflow
      inputs:
        OQ_Input_Bundle:
          type: File
          doc: "Input bundle for OpenQuake hazard calculation"
      outputs:
        Hazard_Calculation_Result:
          type: File
          doc: "Result of the hazard calculation"
      steps:
        SS7102:
          doc: "The OpenQuake engine computes seismic hazard and risk."
          in:
            OQ_Input_Bundle: OQ_Input_Bundle
          run:
            class: Operation
            inputs:
              OQ_Input_Bundle: File
            outputs:
              Hazard_Calculation_Result: File
          out:
            - Hazard_Calculation_Result
    out:
      - Hazard_Calculation_Result

  ST710303:
    doc: "Hazard Output – Hazard Maps, Curves, UHS"
    in:
      Hazard_Calculation_Result: ST710302/Hazard_Calculation_Result
    run:
      class: Operation
      inputs:
        Hazard_Calculation_Result: File
      outputs:
        DT7109: Directory
    out:
      - DT7109
