cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rnanorm
  - cpm
label: rnanorm_cpm
doc: "Calculate counts per million (CPM) for RNA-Seq data.\n\nTool homepage: https://github.com/genialis/RNAnorm"
inputs:
  - id: exp
    type: File
    doc: Input expression matrix (CSV format, with gene IDs as index).
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output file if it exists.
    inputBinding:
      position: 102
      prefix: --force
  - id: out_path
    type: string
    doc: Output or path parameter `out_path`
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Output file path for CPM values (CSV format).
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnanorm:2.2.0--pyhdfd78af_1
