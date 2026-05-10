cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rnanorm
  - fpkm
label: rnanorm_fpkm
doc: "Calculate FPKM values from gene expression data.\n\nTool homepage: https://github.com/genialis/RNAnorm"
inputs:
  - id: exp
    type: File
    doc: Input gene expression file (e.g., CSV, TSV).
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
  - id: gene_lengths
    type:
      - 'null'
      - File
    doc: File containing gene lengths (e.g., CSV, TSV).
    inputBinding:
      position: 102
      prefix: --gene-lengths
  - id: gtf
    type:
      - 'null'
      - File
    doc: GTF file containing gene annotations.
    inputBinding:
      position: 102
      prefix: --gtf
  - id: out_path
    type: string
    doc: Output or path parameter `out_path`
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type: File
    doc: Output file path for FPKM values.
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnanorm:2.2.0--pyhdfd78af_1
