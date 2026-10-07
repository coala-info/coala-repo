cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coreprofiler
  - db
  - get_request_tokens
label: coreprofiler_db_get_request_tokens
doc: "Get request tokens from pubMLST/BigsDB.\n\nTool homepage: https://gitlab.com/ifb-elixirfr/abromics"
inputs:
  - id: consumer_key
    type:
      - 'null'
      - string
    doc: Consumer key for PUBmlst/BIGSdb API.
    inputBinding:
      position: 101
      prefix: --consumer_key
  - id: consumer_secret
    type:
      - 'null'
      - string
    doc: Consumer secret for PUBmlst/BIGSdb API.
    inputBinding:
      position: 101
      prefix: --consumer_secret
  - id: scheme
    type: string
    doc: Scheme name to consider.
    inputBinding:
      position: 101
      prefix: --scheme
outputs:
  - id: stdout
    type: stdout
    doc: Standard output with the request tokens.
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreprofiler:2.0.0--pyhdfd78af_0
stdout: coreprofiler_db_get_request_tokens.out
