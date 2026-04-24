cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - msisensor-rna
  - train
label: msisensor-rna_train
doc: "Train custom model for microsatellite instability detection.\n\nTool homepage:
  https://github.com/xjtu-omics/msisensor-rna"
inputs:
  - id: author
    type:
      - 'null'
      - string
    doc: The author who trained the model.
    inputBinding:
      position: 101
      prefix: --author
  - id: cancer_type
    type: string
    doc: The cancer type for this training. e.g. CRC, STAD, PanCancer etc.
    inputBinding:
      position: 101
      prefix: --cancer_type
  - id: classifier
    type:
      - 'null'
      - string
    doc: The machine learning classifier for MSI detection.
    inputBinding:
      position: 101
      prefix: --classifier
  - id: email
    type:
      - 'null'
      - string
    doc: The email of the author.
    inputBinding:
      position: 101
      prefix: --email
  - id: input
    type: File
    doc: The path of input file.
    inputBinding:
      position: 101
      prefix: --input
  - id: input_description
    type:
      - 'null'
      - string
    doc: The description of the input file.
    inputBinding:
      position: 101
      prefix: --input_description
  - id: model
    type: File
    doc: The trained model of the input file.
    inputBinding:
      position: 101
      prefix: --model
  - id: model_description
    type:
      - 'null'
      - string
    doc: Description for this trained model.
    inputBinding:
      position: 101
      prefix: --model_description
  - id: positive_num
    type:
      - 'null'
      - int
    doc: The minimum positive sample of MSI for training.
    inputBinding:
      position: 101
      prefix: --positive_num
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msisensor-rna:0.1.6--pyhdfd78af_0
stdout: msisensor-rna_train.out
