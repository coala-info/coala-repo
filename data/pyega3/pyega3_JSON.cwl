cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyega3
label: pyega3_JSON
doc: "pyega3: error: argument subcommand: invalid choice: 'JSON' (choose from 'datasets',
  'files', 'fetch')\n\nTool homepage: https://github.com/EGA-archive/ega-download-client"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand to execute (datasets, files, fetch)
    inputBinding:
      position: 1
  - id: config_file
    type:
      - 'null'
      - File
    doc: Path to configuration file
    inputBinding:
      position: 102
      prefix: -cf
  - id: connections
    type:
      - 'null'
      - int
    doc: Number of connections
    inputBinding:
      position: 102
      prefix: -c
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug mode
    inputBinding:
      position: 102
      prefix: -d
  - id: json_output
    type:
      - 'null'
      - boolean
    doc: Output in JSON format
    inputBinding:
      position: 102
      prefix: -j
  - id: max_slice_size
    type:
      - 'null'
      - int
    doc: Maximum slice size
    inputBinding:
      position: 102
      prefix: -ms
  - id: server_file
    type:
      - 'null'
      - File
    doc: Path to server file
    inputBinding:
      position: 102
      prefix: -sf
  - id: trace
    type:
      - 'null'
      - boolean
    doc: Enable trace mode
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyega3:5.2.0--pyhdfd78af_0
stdout: pyega3_JSON.out
