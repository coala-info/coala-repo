cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepsvr
  - train_classifier
label: deepsvr_train_classifier
doc: "Train a new classifier for somatic variant refinement.\n\nTool homepage: https://github.com/griffithlab/deepsvr"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: training_file_path
    type: File
    doc: "Specify the pickle file produced by the 'prepare_data' command to be used to train a new classifier."
    inputBinding:
      position: 101
      prefix: --training-file-path
  - id: label_file_path
    type: File
    doc: "Specify the label (manual review call) pickle file produced by the 'prepare_data' command to be used to train a new classifier."
    inputBinding:
      position: 101
      prefix: --label-file-path
  - id: model_out_file_path
    type:
      - 'null'
      - string
    doc: "Specify output file path for model json file (default:./deepsvr_model.json)"
    inputBinding:
      position: 101
      prefix: --model-out-file-path
  - id: weights_out_file_path
    type:
      - 'null'
      - string
    doc: "Specify output file path for model weights file (default:./deepsvr_model_weights.h5)"
    inputBinding:
      position: 101
      prefix: --weights-out-file-path
outputs:
  - id: model_json
    type: File
    doc: model json file
    outputBinding:
      glob: '$(inputs.model_out_file_path ? inputs.model_out_file_path : "deepsvr_model.json")'
  - id: model_weights
    type: File
    doc: model weights file
    outputBinding:
      glob: '$(inputs.weights_out_file_path ? inputs.weights_out_file_path : "deepsvr_model_weights.h5")'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepsvr:0.1.0--py_0
