cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfftk_stats
label: gfftk_stats
doc: "parse annotation GFF3/tbl and output summary statistics.\n\nTool homepage: https://github.com/nextgenusfs/gfftk"
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
  - id: input
    type: File
    doc: annotation in GFF3 or TBL format
    inputBinding:
      position: 101
      prefix: --input
  - id: input_format
    type:
      - 'null'
      - string
    doc: format of input file [gff3, tbl]
    inputBinding:
      position: 101
      prefix: --input-format
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: write converted output to file
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfftk:26.2.12--pyh1f0d9b5_0
