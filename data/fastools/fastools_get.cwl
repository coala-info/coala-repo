cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastools
  - get
label: fastools_get
doc: "Retrieve a reference sequence and find the location of a specific gene.\n\n\
  Tool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs:
  - id: output
    type: string
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
      - int
    doc: orientation (1=forward, 2=reverse)
    inputBinding:
      position: 104
      prefix: -o
  - id: start
    type:
      - 'null'
      - int
    doc: start of the area of interest
    inputBinding:
      position: 104
      prefix: -s
  - id: stop
    type:
      - 'null'
      - int
    doc: end of the area of interest
    inputBinding:
      position: 104
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_out
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
stdout: fastools_get.out
