cwlVersion: v1.2
class: CommandLineTool
baseCommand: robust-bias-aware
label: robust-bias-aware
doc: "Description of your program\n\nTool homepage: https://github.com/bionetslab/robust_bias_aware_pip_package"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: Alpha value
    inputBinding:
      position: 101
      prefix: --alpha
  - id: beta
    type:
      - 'null'
      - float
    doc: Beta value
    inputBinding:
      position: 101
      prefix: --beta
  - id: gamma
    type:
      - 'null'
      - float
    doc: Gamma value
    inputBinding:
      position: 101
      prefix: --gamma
  - id: n
    type:
      - 'null'
      - int
    doc: n value
    inputBinding:
      position: 101
      prefix: --n
  - id: namespace
    type:
      - 'null'
      - string
    doc: Namespace
    inputBinding:
      position: 101
      prefix: --namespace
  - id: network
    type:
      - 'null'
      - string
    doc: Network type
    inputBinding:
      position: 101
      prefix: --network
  - id: seeds
    type: File
    doc: Path to seeds file
    inputBinding:
      position: 101
      prefix: --seeds
  - id: study_bias_scores
    type:
      - 'null'
      - File
    doc: Study bias scores
    inputBinding:
      position: 101
      prefix: --study_bias_scores
  - id: tau
    type:
      - 'null'
      - float
    doc: Tau value
    inputBinding:
      position: 101
      prefix: --tau
outputs:
  - id: outfile
    type: File
    doc: Output file name
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/robust-bias-aware:0.0.1--pyh7cba7a3_1
