#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}

# Define global inputs.
inputs:
  DT7602:
    doc: "Event alerts from seismic services."
    type: File
  DT7603:
    doc: "Automated peak motions from RRSM."
    type: File
  DT7604:
    doc: "Felt reports from EMSC."
    type: File
  DT7605:
    doc: "Manual peak motions from ESM."
    type: File
  DT7607:
    doc: "Dynamic GMMs / site amplification parameters (DTC-E3)."
    type: File
  useMLStep:
    doc: "Whether to run the optional ML based prediction step (ST760103)."
    type: boolean
  PretrainedMlModel:
    doc: "Pretrained machine learning model to be used in ML step."
    type: File

# Define global outputs.
outputs:
  DT7606:
    doc: "Evolutionary shake maps with finite fault characterization."
    type: File
    outputSource: ST760106/DT7606_FinalShakeMap

steps:
  ST760202:
    doc: "Collect event alerts."
    in:
      EventAlerts: DT7602
    run:
      class: Operation
      inputs:
        EventAlerts: File
      outputs:
        CollectedEventAlerts: File
    out:
      - CollectedEventAlerts

  ST760203:
    doc: "Automated peak motions from RRSM."
    in:
      AutoPeakMotions: DT7603
    run:
      class: Operation
      inputs:
        AutoPeakMotions: File
      outputs:
        IntegratedAutoPeakMotions: File
    out:
      - IntegratedAutoPeakMotions

  ST760204:
    doc: "Integrate felt reports into the workflow."
    in:
      FeltReports: DT7604
    run:
      class: Operation
      inputs:
        FeltReports: File
      outputs:
        IntegratedFeltReports: File
    out:
      - IntegratedFeltReports

  ST760205:
    doc: "Integrate manual peak motions into the workflow."
    in:
      ManualPeaks: DT7605
    run:
      class: Operation
      inputs:
        ManualPeaks: File
      outputs:
        IntegratedManualPeaks: File
    out:
      - IntegratedManualPeaks

  ST760103:
    doc: "ML-based algorithm to estimate peak motions at stations."
    in:
      PretrainedMLModel: PretrainedMlModel
    when: $(inputs.useMLStep)
    run:
      class: Operation
      inputs:
        PretrainedMLModel: File
      outputs:
        MLPredictions: File
    out:
      - MLPredictions

  ST760104:
    doc: "Finite-source characterization using template matching (FinDer)."
    in:
      CollectedEventAlerts: ST760202/CollectedEventAlerts
      IntegratedAutoPeakMotions: ST760203/IntegratedAutoPeakMotions
      IntegratedFeltReports: ST760204/IntegratedFeltReports
      IntegratedManualPeaks: ST760205/IntegratedManualPeaks
      MLPredictions:
        source: ST760103/MLPredictions
        pickValue: first_non_null
    run:
      class: Workflow
      inputs:
        CollectedEventAlerts: File
        IntegratedAutoPeakMotions: File
        IntegratedFeltReports: File
        IntegratedManualPeaks: File
        MLPredictions: ["null", File]
      outputs:
        SourceCharacterization: File
      steps:
        SS7603:
          doc: "FinDer – Generate finite fault solutions."
          in:
            FinDerCollectedAlerts: CollectedEventAlerts
            FinDerAutoPeakMotions: IntegratedAutoPeakMotions
            FinDerFeltReports: IntegratedFeltReports
            FinDerManualPeaks: IntegratedManualPeaks
            FinDerMLPredictions: MLPredictions
          run:
            class: Operation
            inputs:
              FinDerCollectedAlerts: File
              FinDerAutoPeakMotions: File
              FinDerFeltReports: File
              FinDerManualPeaks: File
              FinDerMLPredictions: ["null", File]
            outputs:
              FinDerOutput: File
          out:
            - FinDerOutput
    out:
      - SourceCharacterization

  ST760105:
    doc: "Generate ground motion and shaking intensity maps."
    in:
      SourceCharacterization: ST760104/SourceCharacterization
      SiteAmplifications_DTCE3: DT7607
    run:
      class: Workflow
      inputs:
        SourceCharacterization: File
        SiteAmplifications_DTCE3: File
      outputs:
        ShakeMap: File
      steps:
        SS7601:
          doc: "ShakeMap – Generate ground motion maps."
          in:
            ShakeMapInputSource: SourceCharacterization
            ShakeMapInputAmplifications: SiteAmplifications_DTCE3
          run:
            class: Operation
            inputs:
              ShakeMapInputSource: File
              ShakeMapInputAmplifications: File
            outputs:
              ShakeMapOutput: File
          out:
            - ShakeMapOutput
    out:
      - ShakeMap

  ST760106:
    doc: "Prepare evolutionary shake maps for output using finite fault characterization."
    in:
      ShakeMap: ST760105/ShakeMap
    run:
      class: Operation
      inputs:
        ShakeMap: File
      outputs:
        DT7606_FinalShakeMap: File
    out:
      - DT7606_FinalShakeMap