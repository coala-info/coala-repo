cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastools_get
label: fastools_get
doc: "Retrieve a reference sequence and find the location of a specific gene.\n\n\
  Tool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: output
    type: File
    doc: output file
    inputBinding:
      position: 1
  - id: accno
    type: string
    doc: accession number
    inputBinding:
      position: 2
  - id: email
    type: string
    doc: email address
    inputBinding:
      position: 3
  - id: orientation
    type:
      - 'null'
      - string
    doc: orientation (1=forward, 2=reverse)
    inputBinding:
      position: 104
      prefix: -o
  - id: start
    type:
      - 'null'
      - string
    doc: start of the area of interest
    inputBinding:
      position: 104
      prefix: -s
  - id: stop
    type:
      - 'null'
      - string
    doc: end of the area of interest
    inputBinding:
      position: 104
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
stdout: fastools_get.out
