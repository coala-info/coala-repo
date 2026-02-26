cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastppm
label: fastppm_fastppm-cli
doc: "FastPPM CLI\n\nTool homepage: https://github.com/elkebir-group/fastppm"
inputs:
  - id: format
    type:
      - 'null'
      - type: array
        items: string
    doc: Output format, either 'concise' or 'verbose'
    default: concise
    inputBinding:
      position: 101
      prefix: --format
  - id: loss
    type:
      - 'null'
      - type: array
        items: string
    doc: Loss function L_i(.) to use for optimization
    default: l2
    inputBinding:
      position: 101
      prefix: --loss
  - id: precision
    type:
      - 'null'
      - type: array
        items: int
    doc: Precision parameter, only used when loss function is 'beta_binomial*'
    default: 10
    inputBinding:
      position: 101
      prefix: --precision
  - id: segments
    type:
      - 'null'
      - type: array
        items: int
    doc: Number of segments, only used when loss function is '*_pla' or '*_ppla'
    default: 10
    inputBinding:
      position: 101
      prefix: --segments
  - id: total
    type: File
    doc: Path to the total read matrix file
    inputBinding:
      position: 101
      prefix: --total
  - id: tree
    type: File
    doc: Path to the tree file
    inputBinding:
      position: 101
      prefix: --tree
  - id: variant
    type: File
    doc: Path to the variant read matrix file
    inputBinding:
      position: 101
      prefix: --variant
  - id: weights
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to the weights matrix file
    default: ''
    inputBinding:
      position: 101
      prefix: --weights
outputs:
  - id: output
    type: File
    doc: Path to the output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastppm:1.1.1--py39h2de1943_0
