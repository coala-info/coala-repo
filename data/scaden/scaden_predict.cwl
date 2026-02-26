cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scaden
  - predict
label: scaden_predict
doc: "Predict cell type composition using a trained Scaden model\n\nTool homepage:
  https://github.com/KevinMenden/scaden"
inputs:
  - id: prediction_data
    type: string
    doc: Prediction data
    inputBinding:
      position: 1
  - id: model_dir
    type: string
    doc: Path to trained model
    inputBinding:
      position: 102
      prefix: --model_dir
  - id: seed
    type:
      - 'null'
      - int
    doc: Set random seed
    inputBinding:
      position: 102
      prefix: --seed
outputs:
  - id: outname
    type:
      - 'null'
      - File
    doc: Name of predictions file.
    outputBinding:
      glob: $(inputs.outname)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scaden:1.1.2--pyhdfd78af_0
