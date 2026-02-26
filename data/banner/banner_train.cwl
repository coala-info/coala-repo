cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - banner
  - train
label: banner_train
doc: "Train takes a banner-matrix file from hulk and uses it to train a Random Forest
  Classifier\n\nTool homepage: https://www.github.com/will-rowe/banner"
inputs:
  - id: estimators
    type:
      - 'null'
      - int
    doc: Number of estimators to use for training
    inputBinding:
      position: 101
      prefix: --estimators
  - id: matrix
    type: File
    doc: The matrix from hulk smash
    inputBinding:
      position: 101
      prefix: --matrix
  - id: processors
    type:
      - 'null'
      - int
    doc: Number of processors to use for training
    inputBinding:
      position: 101
      prefix: --processors
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Where to write the model to
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/banner:0.0.2--py_0
