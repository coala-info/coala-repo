cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - iobrpy
  - LR_cal
label: iobrpy_LR_cal
doc: "Compute ligand-receptor interaction scores from an expression matrix.\n\nTool
  homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: input
    type: File
    doc: Path to input expression matrix (genes x samples)
    inputBinding:
      position: 101
      prefix: --input
  - id: data_type
    type:
      - 'null'
      - string
    doc: 'Type of input data: count or tpm'
    inputBinding:
      position: 101
      prefix: --data_type
  - id: id_type
    type:
      - 'null'
      - string
    doc: 'Gene ID type. Choices: ensembl, entrez, symbol, mgi.'
    inputBinding:
      position: 101
      prefix: --id_type
  - id: cancer_type
    type:
      - 'null'
      - string
    doc: Cancer type network
    inputBinding:
      position: 101
      prefix: --cancer_type
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_path
    type: string
    doc: Path to save LR scores
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Path to save LR scores
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
