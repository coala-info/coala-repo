cwlVersion: v1.2
class: CommandLineTool
baseCommand: splitFile
label: ucsc-splitfile
doc: "Split up a file into pieces with a given number of lines. Output files are named by the base name plus a two-digit number.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: The input file to be split.
    inputBinding:
      position: 1
  - id: lines_per_file
    type: int
    doc: The number of lines per output piece.
    inputBinding:
      position: 2
  - id: out_root
    type: string
    doc: The base name for the output files.
    inputBinding:
      position: 3
  - id: head
    type:
      - 'null'
      - File
    doc: Put the contents of this file in front of each output
    inputBinding:
      position: 0
      prefix: -head=
      separate: false
  - id: tail
    type:
      - 'null'
      - File
    doc: Put the contents of this file at the end of each output
    inputBinding:
      position: 0
      prefix: -tail=
      separate: false
outputs:
  - id: out_root_files
    type:
      type: array
      items: File
    doc: Files written with the base name given in out_root
    outputBinding:
      glob: $(inputs.out_root)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-splitfile:482--h0b57e2e_0
