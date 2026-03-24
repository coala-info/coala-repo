#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}

# Global Inputs
inputs:
  DT7301:
    type: File
    doc: "Observed ground motion data from ORFEUS (ESM, RRSM, EIDA)"
  SimulationDataset:
    type: File
    doc: "Simulation input dataset (e.g., SPEED Broadband, DTC E5)"

# Global Outputs
outputs:
  DT7303:
    type: File
    doc: "Ground motion model results"
  UpdatedHazardnRiskProducts:
    type: Directory
    doc: "Updated hazard and risk products" 

# Workflow Steps
steps:
  ST730101:
    doc: "Observed Ground Motion Data: Stream2Segment subworkflow"
    in:
      DT7301: DT7301
    run:
      class: Workflow
      inputs:
        DT7301:
          type: File
          doc: "Observed ground motion data from ORFEUS (ESM, RRSM, EIDA)"
      outputs:
        SegmentedMotion:
          type: File
          doc: "Segmented ground motion data"
      steps:
        SS7301:
          doc: "Stream2Segment"
          in:
            DT7301: DT7301
          run:
            class: Operation
            inputs:
              DT7301: File
            outputs:
              SegmentedMotion: File
          out:
            - SegmentedMotion
    out:
      - SegmentedMotion

  ST730102:
    doc: "Anomaly Detection (SDAAS)"
    in:
      SegmentedMotion: ST730101/SegmentedMotion
    run:
      class: Workflow
      inputs:
        SegmentedMotion:
          type: File
          doc: "Segmented ground motion data"
      outputs:
        DetectedAnomalies:
          type: File
          doc: "Detected anomalies in ground motion data"
      steps:
        SS7303:
          doc: "SDAAS"
          in:
            SegmentedMotion: SegmentedMotion
          run:
            class: Operation
            inputs:
              SegmentedMotion: File
            outputs:
              DetectedAnomalies: File
          out:
            - DetectedAnomalies
    out:
      - DetectedAnomalies

  ST730103:
    doc: "Simulation Data"
    in:
      SimulationDataset: SimulationDataset
    run:
      class: Operation
      inputs:
        SimulationDataset:
          type: File
          doc: "Simulation input dataset (e.g., SPEED Broadband, DTC E5)"
      outputs:
        SimulationProcessed:
          type: File
          doc: "Processed simulation data"
    out:
      - SimulationProcessed

  ST730104:
    doc: "Simulated Ground Motion Comparison & Validation"
    in:
      SimulationProcessed: ST730103/SimulationProcessed
      SegmentedMotion: ST730101/SegmentedMotion
    run:
      class: Operation
      inputs:
        SimulationProcessed:
          type: File
          doc: "Processed simulation data"
        SegmentedMotion:
          type: File
          doc: "Segmented ground motion data"
      outputs:
        ComparisonResults:
          type: File
          doc: "Comparison results of simulated and observed ground motion"
    out:
      - ComparisonResults

  ST730105:
    doc: "Data Assimilation and Harmonisation"
    in:
      SegmentedMotion: ST730101/SegmentedMotion
    run:
      class: Operation
      inputs:
        SegmentedMotion:
          type: File
          doc: "Segmented ground motion data"
      outputs:
        HarmonisedData:
          type: File
          doc: "Harmonised ground motion data"
    out:
      - HarmonisedData

  ST730106:
    doc: "Near-Fault Model"
    in:
      HarmonisedData: ST730105/HarmonisedData
    run:
      class: Operation
      inputs:
        HarmonisedData:
          type: File
          doc: "Harmonised ground motion data"
      outputs:
        NearFaultModelResults:
          type: File
          doc: "Results of the near-fault model"
    out:
      - NearFaultModelResults

  ST730107:
    doc: "Ground Motion Model (GMM)"
    in:
      HarmonisedData: ST730105/HarmonisedData
    run:
      class: Operation
      inputs:
        HarmonisedData:
          type: File
          doc: "Harmonised ground motion data"
      outputs:
        DT7303:
          type: File
          doc: "Ground motion model results"
    out:
      - DT7303

  ST730108:
    doc: "GMM Coefficient Set (OpenQuake Engine)"
    in:
      DT7303: ST730107/DT7303
      DT7301: DT7301
    run:
      class: Workflow
      inputs:
        DT7303:
          type: File
          doc: "Ground motion model results"
        DT7301:
          type: File
          doc: "Observed ground motion data from ORFEUS (ESM, RRSM, EIDA)"
      outputs:
        CoefficientSet:
          type: File
          doc: "GMM coefficient set"
      steps:
        SS7102:
          doc: "OpenQuake engine"
          in:
            DT7303: DT7303
            DT7301: DT7301
          run:
            class: Operation
            inputs:
              DT7303: File
              DT7301: File
            outputs:
              CoefficientSet: File
          out:
            - CoefficientSet
    out:
        - CoefficientSet

  ST730109:
    doc: "Dynamically Updated GMM Coefficients (includes eGSIM and SDAAS)"
    in:
      HarmonisedData: ST730105/HarmonisedData
      ComparisonResults: ST730104/ComparisonResults
    run:
      class: Workflow
      inputs:
        HarmonisedData:
          type: File
          doc: "Harmonised ground motion data"
        ComparisonResults:
          type: File
          doc: "Comparison results of simulated and observed ground motion"
      outputs:
        DT7303:
          type: File
          doc: "Updated GMM coefficients"
      steps:
        SS7302:
          doc: "eGSIM - Residuals and Bayesian Update"
          in:
            HarmonisedData: HarmonisedData
            ComparisonResults: ComparisonResults
          run:
            class: Operation
            inputs:
              HarmonisedData: File
              ComparisonResults: File
            outputs:
              DT7303: File
          out:
            - DT7303
    out:
      - DT7303

  ST730110:
    doc: "Updated Hazard & Risk Products"
    in:
      CoefficientSet: ST730108/CoefficientSet
    run:
      class: Operation
      inputs:
        CoefficientSet: File
      outputs:
        UpdatedHazardnRiskProducts: Directory
    out:
      - UpdatedHazardnRiskProducts