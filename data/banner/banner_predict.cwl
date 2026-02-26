cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - banner
  - predict
label: banner_predict
doc: "Collects sketches from STDIN and classifies them using a RFC\n\nTool homepage:
  https://www.github.com/will-rowe/banner"
inputs:
  - id: model
    type: string
    doc: The model that banner trained
    inputBinding:
      position: 101
      prefix: --model
  - id: probability
    type:
      - 'null'
      - float
    doc: The probability threshold for reporting classifications
    inputBinding:
      position: 101
      prefix: --probability
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print all predictions and probability, even if threshold not met yet
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/banner:0.0.2--py_0
stdout: banner_predict.out
