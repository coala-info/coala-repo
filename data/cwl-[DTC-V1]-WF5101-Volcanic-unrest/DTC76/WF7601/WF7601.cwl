#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}

# Define global inputs.
inputs:
  DT7601:
    doc: "Continuous seismic data (waveforms)."
    type: File
    streamable: true
  DT7607:
    doc: "Dynamic GMMs / site amplification parameters (DTC-E3)."
    type: File
  useMLStep:
    doc: "Whether to run the optional ML based prediction step (ST760103)."
    type: boolean
    default: false
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
  ST760101:
    doc: "Receive continuous seismic waveform data."
    in:
      WaveformData: DT7601
    run:
      class: Operation
      inputs:
        WaveformData: File
      outputs:
        StreamedWaveform: File
    out:
      - StreamedWaveform

  ST760102:
    doc: "Seedlink streaming to processing infrastructure."
    in:
      StreamedWaveform: ST760101/StreamedWaveform
    run:
      class: Workflow
      inputs:
        StreamedWaveform: File
      outputs:
        SeedlinkStream: File
      steps:
        SS7602:
          doc: "SeisComP – Process seismic data from Seedlink stream."
          in:
            SeisComPInput: StreamedWaveform
          run:
            class: Operation
            inputs:
              SeisComPInput: File
            outputs:
              SeisComPOutput: File
          out:
            - SeisComPOutput
    out:
      - SeedlinkStream

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
      SeedlinkStream: ST760102/SeedlinkStream
      MLPredictions:
          source: ST760103/MLPredictions
          pickValue: first_non_null
    run:
      class: Workflow
      inputs:
        SeedlinkStream: File
        MLPredictions: ["null", File]
      outputs:
        SourceCharacterization: File
      steps:
        SS7603:
          doc: "FinDer – Generate finite fault solutions."
          in:
            FinDerInputStream: SeedlinkStream
            FinDerMLPredictions: MLPredictions
          run:
            class: Operation
            inputs:
              FinDerInputStream: File
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