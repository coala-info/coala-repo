cwlVersion: v1.2
class: CommandLineTool
baseCommand: graph2asqg
label: lightstringgraph_graph2asqg
doc: "Converts a string graph to ASQG format.\n\nTool homepage: http://lsg.algolab.eu"
inputs:
  - id: basename
    type: string
    doc: basename
    inputBinding:
      position: 101
      prefix: -b
  - id: numeric_ids
    type:
      - 'null'
      - boolean
    doc: use numeric IDs instead of FASTA IDs
    inputBinding:
      position: 101
      prefix: -n
  - id: read_filename
    type:
      - 'null'
      - File
    doc: read_filename
    inputBinding:
      position: 101
      prefix: -r
  - id: read_length
    type: int
    doc: read_length
    inputBinding:
      position: 101
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lightstringgraph:0.4.0--h9948957_7
stdout: lightstringgraph_graph2asqg.out
