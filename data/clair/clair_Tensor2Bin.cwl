cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clair.py
  - Tensor2Bin
label: clair_Tensor2Bin
doc: "Generate a binary format input tensor\n\nTool homepage: https://github.com/HKU-BAL/Clair"
inputs:
  - id: tensor_fn
    type: File
    doc: "Tensor input"
    inputBinding:
      position: 101
      prefix: --tensor_fn
  - id: var_fn
    type: File
    doc: "Truth variants list input"
    inputBinding:
      position: 101
      prefix: --var_fn
  - id: bed_fn
    type:
      - 'null'
      - File
    doc: "High confident genome regions input in the BED format"
    inputBinding:
      position: 101
      prefix: --bed_fn
  - id: bin_fn
    type: string
    doc: "Output a binary tensor file"
    inputBinding:
      position: 101
      prefix: --bin_fn
  - id: shuffle
    type:
      - 'null'
      - boolean
    doc: "Shuffle on building bin"
    inputBinding:
      position: 101
      prefix: --shuffle
  - id: allow_duplicate_chr_pos
    type:
      - 'null'
      - boolean
    doc: "Allow duplicate chromosome:position in tensor input"
    inputBinding:
      position: 101
      prefix: --allow_duplicate_chr_pos
outputs:
  - id: bin
    type: File
    doc: "Binary tensor file"
    outputBinding:
      glob: "$(inputs.bin_fn)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair:2.1.1--hdfd78af_1
