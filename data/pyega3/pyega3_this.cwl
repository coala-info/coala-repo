cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyega3
label: pyega3_this
doc: "pyega3: error: argument subcommand: invalid choice: 'this' (choose from 'datasets',
  'files', 'fetch')\n\nTool homepage: https://github.com/EGA-archive/ega-download-client"
inputs:
  - id: subcommand
    type:
      type: array
      items: string
    doc: 'Subcommand to run: datasets, files, fetch'
    inputBinding:
      position: 1
  - id: config_file
    type:
      - 'null'
      - File
    inputBinding:
      position: 102
      prefix: --config-file
  - id: connections
    type:
      - 'null'
      - int
    inputBinding:
      position: 102
      prefix: --connections
  - id: debug
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: -d
  - id: json_output
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: -j
  - id: max_slice_size
    type:
      - 'null'
      - int
    inputBinding:
      position: 102
      prefix: --max-slice-size
  - id: server_file
    type:
      - 'null'
      - File
    inputBinding:
      position: 102
      prefix: --server-file
  - id: test_mode
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
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
stdout: pyega3_this.out
