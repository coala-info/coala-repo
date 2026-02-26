cwlVersion: v1.2
class: CommandLineTool
baseCommand: lsg
label: lightstringgraph_lsg
doc: "Light String Graph tool\n\nTool homepage: http://lsg.algolab.eu"
inputs:
  - id: basename
    type: string
    doc: basename
    inputBinding:
      position: 101
      prefix: --basename
  - id: cyc_num
    type:
      - 'null'
      - int
    doc: CycNum
    default: 0
    inputBinding:
      position: 101
      prefix: --CycNum
  - id: gsa_filename
    type:
      - 'null'
      - File
    doc: GSAFilename
    default: <basename>.pairSA
    inputBinding:
      position: 101
      prefix: --GSA
  - id: read_length
    type:
      - 'null'
      - int
    doc: readLength. 0 if unknown or not fixed
    default: 0
    inputBinding:
      position: 101
      prefix: --read-length
  - id: tau
    type:
      - 'null'
      - float
    doc: TAU
    default: 0
    inputBinding:
      position: 101
      prefix: --TAU
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lightstringgraph:0.4.0--h9948957_7
stdout: lightstringgraph_lsg.out
