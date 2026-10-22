cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smof
  - cut
label: smof_cut
doc: "Print sequences by index (emulates the UNIX cut command, where fields are entries).\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: fields
    type:
      - 'null'
      - string
    doc: "Indices to print, comma delimited, with ranges"
    inputBinding:
      position: 100
      prefix: --fields
  - id: complement
    type:
      - 'null'
      - boolean
    doc: "Invert selection"
    inputBinding:
      position: 101
      prefix: --complement
  - id: input_file
    type: File
    doc: "Input FASTA file (smof reads standard input by default)"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_cut.out
