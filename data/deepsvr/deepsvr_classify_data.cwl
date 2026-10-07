cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepsvr
  - classify_data
label: deepsvr_classify_data
doc: "Preform automated somatic variant refinement on mutations.\n\nTool homepage: https://github.com/griffithlab/deepsvr"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: prepared_data_path
    type: File
    doc: "Specify the 'train.pkl' file produced by the 'prepare_data' to perform inference on. Ignore the call.pkl used in training classifiers"
    inputBinding:
      position: 101
      prefix: --prepared-data-path
  - id: model_file_path
    type: File
    doc: "Specify the file path for the model json file. Created by the train_classifier command."
    inputBinding:
      position: 101
      prefix: --model-file-path
  - id: model_weights_path
    type: File
    doc: "Specify the file path for the model weights file. Created by the train_classifier command."
    inputBinding:
      position: 101
      prefix: --model-weights-path
  - id: predictions_out_path
    type: string
    doc: "Specify the file path for the predictions tab separated file."
    inputBinding:
      position: 101
      prefix: --predictions-out-path
outputs:
  - id: predictions
    type: File
    doc: predictions tab separated file
    outputBinding:
      glob: $(inputs.predictions_out_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepsvr:0.1.0--py_0
