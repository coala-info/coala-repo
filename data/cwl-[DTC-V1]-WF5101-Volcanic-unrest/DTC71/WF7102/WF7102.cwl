cwlVersion: v1.2
class: Workflow

requirements:
    SubworkflowFeatureRequirement: {}

inputs:
  DT7104:
    doc: "Seismogenic Source Model of the 2020 European Seismic Hazard Model (ESHM20)."
    type: File
  CRUSTAL_FAULT_MODEL:
    doc: "Output dataset for ST710105."
    type: File
  SUBDUCTION_ZONES:
    doc: "Output dataset for ST710105."
    type: File
  ACTIVE_FAULT_DATASET:
    doc: "Output dataset of ST710104."
    type: File
outputs:
  DT7108:
    doc: "Updated Seismogenic Source Model."
    type: File

steps:
  ST710201:
    doc: "Seismogenic Sources Model (SSM). EFEHR static repository."
    in:
      ESHM20: DT7104
    run:
      class: Workflow
      inputs:
        ESHM20:
          type: File
          doc: "Seismogenic Source Model of the 2020 European Seismic Hazard Model (ESHM20)."
      outputs:
        SSM:
          type: File
          doc: "Seismogenic Sources Model output file."
      steps:
        SS7101:
          doc: "Subworkflow for processing the Seismogenic Sources Model."
          in:
            ESHM20: ESHM20
          run:
            class: Operation
            inputs:
              ESHM20: File
            outputs:
              SSM: File
          out:
            - SSM
    out:
      - SSM

  ST710202:
    doc: "Data Retrieval and Transformation."
    in:
      SSM: ST710201/SSM
    run:
      class: Operation
      inputs:
        SSM: File
      outputs:
        TRANSFORMED_DATA: File
    out:
      - TRANSFORMED_DATA

  ST710203:
    doc: "Estimation of Activity Rates."
    in:
      TRANSFORMED_DATA: ST710202/TRANSFORMED_DATA
      CRUSTAL_FAULT_MODEL: CRUSTAL_FAULT_MODEL
      SUBDUCTION_ZONES: SUBDUCTION_ZONES
      ACTIVE_FAULT_DATASET: ACTIVE_FAULT_DATASET
    run:
      class: Operation
      inputs:
        TRANSFORMED_DATA: File
        CRUSTAL_FAULT_MODEL: File
        SUBDUCTION_ZONES: File
        ACTIVE_FAULT_DATASET: File
      outputs:
        ACTIVITY_RATES: File
    out:
      - ACTIVITY_RATES

  ST710204:
    doc: "Long Term Earthquake Forecasts."
    in:
      ACTIVITY_RATES: ST710203/ACTIVITY_RATES
    run:
      class: Operation
      inputs:
        ACTIVITY_RATES: File
      outputs:
        LONGTERM_FORECASTS: File
    out:
      - LONGTERM_FORECASTS

  ST710205:
    doc: "Update of Seismogenic Source Model."
    in:
      FORECASTS: ST710204/LONGTERM_FORECASTS
    run:
      class: Operation
      inputs:
        FORECASTS: File
      outputs:
        DT7108: File
    out:
      - DT7108
