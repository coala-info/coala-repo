cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_overlapping_genes.py
label: tsebra_get_overlapping_genes
doc: "Compare two gene sets in GTF format and write three GTF files with the overlapping and the not overlapping genes.\n\nTool homepage: https://github.com/Gaius-Augustus/TSEBRA"
inputs:
  - id: geneset1
    type: File
    doc: "First gene set in GTF format"
    inputBinding:
      position: 101
      prefix: -g1
  - id: geneset2
    type: File
    doc: "Second gene set in GTF format"
    inputBinding:
      position: 101
      prefix: -g2
  - id: out_path
    type: string
    doc: "Output file prefix or path"
    inputBinding:
      position: 101
      prefix: -o
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Quiet mode"
    inputBinding:
      position: 101
      prefix: -q
  - id: verbose
    type:
      - 'null'
      - int
    doc: "Verbosity level"
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: out_files
    type:
      type: array
      items: File
    doc: "Output GTF files with overlapping and not overlapping genes"
    outputBinding:
      glob: "$(inputs.out_path)*"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsebra:1.1.2.5--pyhca03a8a_0
