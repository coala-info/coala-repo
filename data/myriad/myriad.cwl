cwlVersion: v1.2
class: CommandLineTool
baseCommand: myriad
label: myriad
doc: "Run myriad client or server-client demo\n\nTool homepage: https://github.com/cjw85/myriad"
inputs:
  - id: client
    type:
      - 'null'
      - boolean
    doc: Run client
    inputBinding:
      position: 101
      prefix: --client
  - id: host
    type:
      - 'null'
      - string
    doc: Host to connect to
    inputBinding:
      position: 101
      prefix: --host
  - id: key
    type:
      - 'null'
      - string
    doc: Key for authentication
    inputBinding:
      position: 101
      prefix: --key
  - id: max_items
    type:
      - 'null'
      - int
    doc: Maximum number of items to process
    inputBinding:
      position: 101
      prefix: --max_items
  - id: port
    type:
      - 'null'
      - int
    doc: Port to connect to
    inputBinding:
      position: 101
      prefix: --port
  - id: serverclient
    type:
      - 'null'
      - boolean
    doc: Run server-client demo
    inputBinding:
      position: 101
      prefix: --serverclient
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/myriad:0.1.4--py27_0
stdout: myriad.out
