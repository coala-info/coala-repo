cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - refgenieserver
  - serve
label: refgenieserver_serve
doc: "run the server\n\nTool homepage: https://refgenie.databio.org/"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: "A path to the refgenie config file (YAML). If not provided, the first available
      environment variable among: 'REFGENIE' will be used if set. Currently: not set"
    inputBinding:
      position: 101
      prefix: --config
  - id: dbg
    type:
      - 'null'
      - boolean
    doc: Set logger verbosity to debug
    inputBinding:
      position: 101
      prefix: --dbg
  - id: port
    type:
      - 'null'
      - int
    doc: The port the webserver should be run on.
    inputBinding:
      position: 101
      prefix: --port
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refgenieserver:0.7.0--pyhdfd78af_0
stdout: refgenieserver_serve.out
