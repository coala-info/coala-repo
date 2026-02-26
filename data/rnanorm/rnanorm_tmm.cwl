cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rnanorm
  - tmm
label: rnanorm_tmm
doc: "Apply TMM normalization to an expression matrix.\n\nTool homepage: https://github.com/genialis/RNAnorm"
inputs:
  - id: expression_matrix
    type: File
    doc: Path to the input expression matrix (CSV format, gene names as index).
    inputBinding:
      position: 1
  - id: a_trim
    type:
      - 'null'
      - float
    doc: Proportion of genes to trim from the median calculation (upper bound).
    default: 0.01
    inputBinding:
      position: 102
      prefix: --a-trim
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite the output file if it already exists.
    inputBinding:
      position: 102
      prefix: --force
  - id: m_trim
    type:
      - 'null'
      - float
    doc: Proportion of genes to trim from the median calculation (lower bound).
    default: 0.01
    inputBinding:
      position: 102
      prefix: --m-trim
outputs:
  - id: output_file
    type: File
    doc: Path to save the normalized expression matrix.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnanorm:2.2.0--pyhdfd78af_1
