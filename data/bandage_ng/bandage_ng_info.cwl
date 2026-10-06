cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - BandageNG
  - info
label: bandage_ng_info
doc: "Display information about a graph. Bandage info takes a graph file as input\
  \ and outputs (to stdout) statistics about the graph.\n\nTool homepage: https://github.com/asl/BandageNG"
inputs:
  - id: graph
    type: File
    doc: A graph file of any type supported by Bandage
    inputBinding:
      position: 2
  - id: tsv
    type:
      - 'null'
      - boolean
    doc: Output the information in a single tab-delimited line starting with the graph
      file
    inputBinding:
      position: 1
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
    dockerPull: quay.io/biocontainers/bandage_ng:2026.9.1--hca0ed12_0
stdout: bandage_ng_info.txt
