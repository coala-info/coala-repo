cwlVersion: v1.2
class: CommandLineTool
baseCommand: redbuild
label: lightstringgraph_redbuild
doc: "Builds a light string graph.\n\nTool homepage: http://lsg.algolab.eu"
inputs:
  - id: basename
    type: string
    doc: basename
    inputBinding:
      position: 101
      prefix: -b
  - id: bucket_length
    type:
      - 'null'
      - int
    doc: bucket length
    default: 1000000
    inputBinding:
      position: 101
      prefix: -g
  - id: max_arc_length
    type: int
    doc: max_arc_length
    inputBinding:
      position: 101
      prefix: -m
  - id: r
    type:
      - 'null'
      - boolean
    default: true
    inputBinding:
      position: 101
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lightstringgraph:0.4.0--h9948957_7
stdout: lightstringgraph_redbuild.out
