cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfftk_compare
label: gfftk_compare
doc: "compare two GFF3 annotations of a genome.\n\nTool homepage: https://github.com/nextgenusfs/gfftk"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: write parsing errors to stderr
    inputBinding:
      position: 101
      prefix: --debug
  - id: fasta
    type: File
    doc: genome in FASTA format
    inputBinding:
      position: 101
      prefix: --fasta
  - id: query
    type: File
    doc: query annotation in GFF3 format
    inputBinding:
      position: 101
      prefix: --query
  - id: reference
    type: File
    secondaryFiles:
      - .fai
    doc: query annotation in GFF3 format
    inputBinding:
      position: 101
      prefix: --reference
  - id: out_path
    type: string
    doc: Output or path parameter `out_path`
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: write converted output to file
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfftk:26.2.12--pyh1f0d9b5_0
