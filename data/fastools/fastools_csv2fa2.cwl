cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastools csv2fa2
label: fastools_csv2fa2
doc: "Convert a CSV file to two FASTA files.\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: output
    type:
      type: array
      items: File
    doc: output files
    inputBinding:
      position: 2
  - id: skip_first_line
    type:
      - 'null'
      - boolean
    doc: skip the first line of the CSV file
    inputBinding:
      position: 103
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
stdout: fastools_csv2fa2.out
