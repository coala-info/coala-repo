#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

inputs:
  MONITORING_TRIGGER:
    type: File

outputs:
  SIMULATED_CATALOGS:
    type: File
    outputSource: ST720207/SIMULATED_CATALOGS

# this uses the ETAS Code SS7501 to calibrate and issue a forecast
steps:
  ST720205:
    doc: "ETAS model inversion"
    in:
      FORECAST_INPUT: MONITORING_TRIGGER
    run:
      class: Operation
      inputs:
        FORECAST_INPUT: File
      outputs:
        INVERSION_RESULTS: File
    out:
      - INVERSION_RESULTS

  ST720206:
    doc: "Sequence-specific model update"
    in:
      INVERSION_RESULTS: ST720205/INVERSION_RESULTS
    run:
      class: Operation
      inputs:
        INVERSION_RESULTS: File
      outputs:
        UPDATED_MODEL: File
    out:
      - UPDATED_MODEL

  ST720207:
    doc: "Catalog simulations"
    in:
      UPDATED_MODEL: ST720206/UPDATED_MODEL
    run:
      class: Operation
      inputs:
        UPDATED_MODEL: File
      outputs:
        SIMULATED_CATALOGS: File
    out:
      - SIMULATED_CATALOGS