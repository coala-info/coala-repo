cwlVersion: v1.2
class: CommandLineTool
baseCommand: blast2galaxy list-dbs
label: blast2galaxy_list-dbs
doc: "list available databases of a BLAST+ or DIAMOND tool installed on a Galaxy server\n\
  \nTool homepage: https://github.com/IPK-BIT/blast2galaxy"
inputs:
  - id: server
    type:
      - 'null'
      - string
    doc: Server-ID as in your config TOML
    default: default
    inputBinding:
      position: 101
      prefix: --server
  - id: tool
    type: string
    doc: Tool-ID of a tool available on the Galaxy server
    inputBinding:
      position: 101
      prefix: --tool
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blast2galaxy:1.0.0--pyhdfd78af_0
stdout: blast2galaxy_list-dbs.out
