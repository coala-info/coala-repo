cwlVersion: v1.2
class: CommandLineTool
baseCommand: im2deep
label: im2deep
doc: "Converts an image to a deep learning model.\n\nTool homepage: https://github.com/compomics/im2deep"
inputs:
  - id: input_file
    type: File
    doc: The input image file.
    inputBinding:
      position: 1
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size for training.
    inputBinding:
      position: 102
      prefix: --batch-size
  - id: epochs
    type:
      - 'null'
      - int
    doc: Number of training epochs.
    inputBinding:
      position: 102
      prefix: --epochs
  - id: learning_rate
    type:
      - 'null'
      - float
    doc: Learning rate for the optimizer.
    inputBinding:
      position: 102
      prefix: --learning-rate
  - id: model_type
    type:
      - 'null'
      - string
    doc: Type of model to use (e.g., resnet18, vgg16).
    inputBinding:
      position: 102
      prefix: --model-type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save the model files. Defaults to the current directory.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/im2deep:1.2.0--pyhdfd78af_0
