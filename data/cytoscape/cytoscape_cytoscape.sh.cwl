cwlVersion: v1.2
class: CommandLineTool
baseCommand: cytoscape.sh
label: cytoscape_cytoscape.sh
doc: "Cytoscape Command-line Arguments\n\nTool homepage: https://cytoscape.org"
inputs:
  - id: network_file
    type:
      - 'null'
      - File
    doc: Load a network file (any format).
    inputBinding:
      position: 101
      prefix: --network
  - id: props_file
    type:
      - 'null'
      - File
    doc: 'Load cytoscape properties file (Java properties format) or individual property:
      -P name=value.'
    inputBinding:
      position: 101
      prefix: --props
  - id: rest_port
    type:
      - 'null'
      - int
    doc: Start a rest service.
    inputBinding:
      position: 101
      prefix: --rest
  - id: script_file
    type:
      - 'null'
      - File
    doc: Execute commands from script file.
    inputBinding:
      position: 101
      prefix: --script
  - id: session_file
    type:
      - 'null'
      - File
    doc: Load a cytoscape session (.cys) file.
    inputBinding:
      position: 101
      prefix: --session
  - id: vizmap_file
    type:
      - 'null'
      - File
    doc: Load vizmap properties file (Cytoscape VizMap format).
    inputBinding:
      position: 101
      prefix: --vizmap
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cytoscape:3.10.4--he65b2d3_0
stdout: cytoscape_cytoscape.sh.out
