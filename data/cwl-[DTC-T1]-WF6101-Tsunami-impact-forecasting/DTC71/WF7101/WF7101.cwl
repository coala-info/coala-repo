cwlVersion: v1.2
class: Workflow

# Define global inputs.
inputs:
  DT7101:
    doc: "European instrumental earthquake catalogue (EMEC)."
    type: File
  DT7102:
    doc: "European PreInstrumental Earthquake Catalogue (EPICA)"
    type: File
  DT7103:
    doc: "European Fault-Source Model."
    type: File

# Define global outputs.
outputs:
  CRUSTAL_FAULT_MODEL:
    doc: "Output dataset for ST710105."
    type: File
    outputSource: ST710105/CRUSTAL_FAULT_MODEL
  SUBDUCTION_ZONES:
    doc: "Output dataset for ST710105."
    type: File
    outputSource: ST710105/SUBDUCTION_ZONES 
  ACTIVE_FAULT_DATASET:
    doc: "Output dataset of ST710104."
    type: File
    outputSource: ST710104/ACTIVE_FAULT_DATASET

# Define workflow steps.
steps:
  ST710101:
    doc: "Harmonization of Earthquake Catalogs."
    in:
      EMEC_DATA: DT7101
      EPICA_DATA: DT7102
    run:
      class: Operation
      inputs:
        EMEC_DATA: File
        EPICA_DATA: File
      outputs:
        HARMONIZED_CATALOG: File
    out:
      - HARMONIZED_CATALOG

  ST710103:
    doc: "Statistical Analysis of the Earthquake Catalog."
    in:
      CLEANED_DATA: ST710101/HARMONIZED_CATALOG
    run:
      class: Operation
      inputs:
        CLEANED_DATA: File
      outputs:
        STATISTICAL_ANALYSIS: File
    out:
      - STATISTICAL_ANALYSIS

  ST710105:
    doc: "Update Crustal Faults Model and Subduction Zones."
    in:
      STATISTICAL_ANALYSIS: ST710103/STATISTICAL_ANALYSIS
    run:
      class: Operation
      inputs:
        STATISTICAL_ANALYSIS: File
      outputs:
        CRUSTAL_FAULT_MODEL: File
        SUBDUCTION_ZONES: File
    out:
      - CRUSTAL_FAULT_MODEL
      - SUBDUCTION_ZONES

  ST710102:
    doc: "Data Cleaning and Feature Selection."
    in:
      ESFM_DATA: DT7103
    run:
      class: Operation
      inputs:
        ESFM_DATA: File
      outputs:
        CLEANED_DATA: File
    out:
      - CLEANED_DATA

  ST710104:
    doc: "Harmonize Active Fault Dataset."
    in:
      CLEANED_ETL: ST710102/CLEANED_DATA
    run:
      class: Operation
      inputs:
        CLEANED_ETL: File
      outputs:
        ACTIVE_FAULT_DATASET: File
    out:
      - ACTIVE_FAULT_DATASET
