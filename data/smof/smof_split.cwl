cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof_split
label: smof_split
doc: "Breaks a multiple sequence fasta file into several smaller files.\n\nTool homepage:
  https://github.com/incertae-sedis/smof"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: input fasta sequence (default = stdin)
    inputBinding:
      position: 1
  - id: number
    type:
      - 'null'
      - int
    doc: Number of output files or sequences per file
    inputBinding:
      position: 102
      prefix: --number
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for output files (default="xxx")
    inputBinding:
      position: 102
      prefix: --prefix
  - id: seqs
    type:
      - 'null'
      - boolean
    doc: split by maximum sequences per file
    inputBinding:
      position: 102
      prefix: --seqs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_split.out
