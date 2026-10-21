cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rnanorm
  - uq
label: rnanorm_uq
doc: "Performs Upper Quartile Normalization on expression data.\n\nTool homepage:
  https://github.com/genialis/RNAnorm"
inputs:
  - id: exp
    type: File
    doc: Path to the input expression file (CSV or TSV, genes in columns).
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite the output file if it already exists.
    inputBinding:
      position: 102
      prefix: --force
  - id: out_path
    type: string
    doc: Output file name
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type: File
    doc: Path to save the normalized expression data (CSV format).
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnanorm:2.2.0--pyhdfd78af_1
