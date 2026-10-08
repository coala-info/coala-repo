cwlVersion: v1.2
class: CommandLineTool
baseCommand: falcon2gfa
label: gfa1_falcon2gfa
doc: "Convert a FALCON string graph edge list (sg_edges_list) to GFA.\n\nTool homepage: https://github.com/lh3/gfa1"
inputs:
  - id: no_sequence
    type:
      - 'null'
      - boolean
    doc: "don't output sequence in GFA"
    inputBinding:
      position: 1
      prefix: -S
  - id: sg_edges_list
    type: File
    doc: "FALCON sg_edges_list file"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: "GFA written to standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfa1:0.53.alpha--h577a1d6_3
stdout: gfa1_falcon2gfa.gfa
