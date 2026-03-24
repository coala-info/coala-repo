#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}

# Define global inputs.
inputs:
  REALTIME_CATALOG:
    doc: "Real-time earthquake catalog input (GFZ-EMEC / FDSN)"
    type: File
    streamable: true
  HIGH_RES_CATALOG:
    doc: "High-resolution seismic event catalog from WF7201 or DT7202 or DT7203"
    type: File
  # all the following inputs are optional
  # DT7202:
  #   doc: "Swiss National Earthquake Catalogue"
  #   type: File
  # DT7203:
  #   doc: "EMSC catalog"
  #   type: File

# Define global outputs.
outputs:
  DT7201:
    doc: "Forecast database populated for use in forecast and visualization"
    type: File
    outputSource: ST720208/DB_OUTPUT
  DT7204:
    doc: "Test results of forecast performance"
    type: File
    outputSource: ST720211/TESTING_RESULTS

# Define workflow steps.
steps:
  ST720201:
    doc: "Ingest real-time input earthquake catalogs"
    in:
      REALTIME_CATALOG: REALTIME_CATALOG
    run:
      class: Operation
      inputs:
        REALTIME_CATALOG: File
      outputs:
        INGESTED_CATALOG: File
    out:
      - INGESTED_CATALOG

  ST720202:
    doc: "HERMES – Harmonize and merge input data"
    in:
      INGESTED_CATALOG: ST720201/INGESTED_CATALOG
      HIGH_RES_CATALOG: HIGH_RES_CATALOG
    run:
      class: Operation
      inputs:
        INGESTED_CATALOG: File
        HIGH_RES_CATALOG: File
      outputs:
        HERMES_PARAMETERS: File
    out:
      - HERMES_PARAMETERS

  ST720203:
      doc: "Activity monitoring and scheduling (model and forecast update)"
      in:
        HERMES_INPUT: ST720202/HERMES_PARAMETERS
      run:
        class: Workflow
        inputs:
          HERMES_INPUT: File
        outputs:
          SCHEDULE_OUTPUT: File
        steps:
          SS7203:
            doc: "HERMES Scheduler – Schedule model updates and forecasts"
            in:
              SCHEDULE_INPUT: HERMES_INPUT
            run:
              class: Operation
              inputs:
                SCHEDULE_INPUT: File
              outputs:
                SCHEDULE_OUTPUT: File
            out:
              - SCHEDULE_OUTPUT
      out:
        - SCHEDULE_OUTPUT

  # this step includes ST720205--ST720207
  ST720204:
    doc: "ETAS forecast process (subworkflow: inversion, update, simulations)"
    in:
      MONITORING_TRIGGER: ST720203/SCHEDULE_OUTPUT
    run: ST720204.cwl
    out:
      - SIMULATED_CATALOGS

  ST720208:
    doc: "Forecast database"
    in:
      FORECAST_DB: ST720204/SIMULATED_CATALOGS
    run:
      class: Operation
      inputs:
        FORECAST_DB: File
      outputs:
        DB_OUTPUT: File
    out:
      - DB_OUTPUT

  ST720209:
    doc: "Web service for forecast access, including visualization"
    in:
      DB_INPUT: ST720208/DB_OUTPUT
    run:
      class: Workflow
      inputs:
        DB_INPUT: File
      outputs:
        WEBSERVICE_OUTPUT: File
      steps:
        SS7502:
          doc: "Forecast Webservice – Visualize and provide forecasts"
          in:
            FORECAST_INPUT: DB_INPUT
          run:
            class: Operation
            inputs:
              FORECAST_INPUT: File
            outputs:
              WEBSERVICE_OUTPUT: File
          out:
            - WEBSERVICE_OUTPUT
    out:
      - WEBSERVICE_OUTPUT

  ST720210:
    doc: "Visualization of forecast"
    in:
      FORECAST_DATA: ST720209/WEBSERVICE_OUTPUT
    run:
      class: Operation
      inputs:
        FORECAST_DATA: File
      outputs:
        VISUALIZATION_OUTPUT: File
    out:
      - VISUALIZATION_OUTPUT

  ST720211:
    doc: "Prospective testing of forecasts, including CSEP Testing"
    in:
      FORECAST_DATA: ST720209/WEBSERVICE_OUTPUT
    run:
      class: Workflow
      inputs:
        FORECAST_DATA: File
      outputs:
        TESTING_RESULTS: File
      steps:
        SS7504:
          doc: "CSEP Testing – Run tests on forecasts"
          in:
            TEST_INPUT: FORECAST_DATA
          run:
            class: Operation
            inputs:
              TEST_INPUT: File
            outputs:
              TESTING_RESULTS: File
          out:
            - TESTING_RESULTS
    out:
      - TESTING_RESULTS