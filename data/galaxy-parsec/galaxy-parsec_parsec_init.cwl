cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - parsec
  - init
label: galaxy-parsec_parsec_init
doc: "Help initialize global configuration (in home directory). Writes the Galaxy
  URL and API key to the parsec configuration file.\n\nTool homepage: https://github.com/galaxy-iuc/parsec"
inputs:
  - id: url
    type:
      - 'null'
      - string
    doc: your Galaxy's URL
    inputBinding:
      position: 1
      prefix: --url
  - id: api_key
    type:
      - 'null'
      - string
    doc: your Galaxy API Key
    inputBinding:
      position: 2
      prefix: --api_key
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-parsec:1.16.0--pyh5e36f6f_0
stdout: galaxy-parsec_parsec_init.out
