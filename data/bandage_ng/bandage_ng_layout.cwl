cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - BandageNG
  - layout
label: bandage_ng_layout
doc: "Layout the graph\n\nTool homepage: https://github.com/asl/BandageNG"
inputs:
  - id: graph
    type: File
    doc: A graph file of any type supported by Bandage
    inputBinding:
      position: 2
  - id: layout
    type: string
    doc: The layout file to be created (must end with .tsv or .layout)
    inputBinding:
      position: 3
outputs:
  - id: layout_file
    type: File
    doc: Graph layout file
    outputBinding:
      glob: $(inputs.layout)
requirements:
  - class: EnvVarRequirement
    envDef:
      QT_QPA_PLATFORM: offscreen
      XDG_RUNTIME_DIR: /tmp
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bandage_ng:2026.9.1--hca0ed12_0
