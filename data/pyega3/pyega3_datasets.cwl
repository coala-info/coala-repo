cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyega3
arguments:
  - position: 10
    valueFrom: datasets
label: pyega3_datasets
doc: "List authorized datasets.\n\nTool homepage: https://github.com/EGA-archive/ega-download-client"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Extra debugging messages."
    inputBinding:
      position: 1
      prefix: --debug
  - id: config_file
    type:
      - 'null'
      - File
    doc: "JSON file containing credentials/config, e.g. {\"username\":\"user1\",\"password\":\"toor\"}."
    inputBinding:
      position: 2
      prefix: --config-file
  - id: server_file
    type:
      - 'null'
      - File
    doc: "JSON file containing server config (url_auth, url_api, url_api_ticket, client_secret)."
    inputBinding:
      position: 3
      prefix: --server-file
  - id: connections
    type:
      - 'null'
      - int
    doc: "Download using specified number of connections (default: 1 connection)."
    inputBinding:
      position: 4
      prefix: --connections
  - id: test
    type:
      - 'null'
      - boolean
    doc: "Test user activated."
    inputBinding:
      position: 5
      prefix: --test
  - id: max_slice_size
    type:
      - 'null'
      - int
    doc: "Set maximum size for each slice in bytes (default: 100 MB)."
    inputBinding:
      position: 6
      prefix: --max-slice-size
  - id: json
    type:
      - 'null'
      - boolean
    doc: "Output data in JSON format instead of tables."
    inputBinding:
      position: 7
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyega3:5.2.0--pyhdfd78af_0
stdout: pyega3_datasets.out
