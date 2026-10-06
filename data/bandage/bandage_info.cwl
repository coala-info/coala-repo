cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Bandage
  - info
label: bandage_info
doc: "Bandage info takes a graph file as input and outputs (to stdout) statistics\
  \ about the graph (node and edge counts, lengths, dead ends, connected components,\
  \ N50, node length quartiles, depth).\n\nTool homepage: https://github.com/rrwick/Bandage"
inputs:
  - id: graph
    type: File
    doc: A graph file of any type supported by Bandage
    inputBinding:
      position: 1
  - id: tsv
    type:
      - 'null'
      - boolean
    doc: Output the information in a single tab-delimited line starting with the graph
      file
    inputBinding:
      position: 2
      prefix: --tsv
outputs:
  - id: info
    type: stdout
    doc: Graph statistics
requirements:
  - class: EnvVarRequirement
    envDef:
      QT_QPA_PLATFORM: offscreen
      XDG_RUNTIME_DIR: /tmp
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bandage:0.9.0--h9948957_0
stdout: bandage_info.txt
