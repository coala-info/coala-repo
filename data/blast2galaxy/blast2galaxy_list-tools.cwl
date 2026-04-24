cwlVersion: v1.2
class: CommandLineTool
baseCommand: blast2galaxy list-tools
label: blast2galaxy_list-tools
doc: "list available and compatible BLAST+ and DIAMOND tools installed on a Galaxy
  server\n\nTool homepage: https://github.com/IPK-BIT/blast2galaxy"
inputs:
  - id: server
    type:
      - 'null'
      - string
    doc: Server-ID as in your config TOML
    inputBinding:
      position: 101
      prefix: --server
  - id: type
    type:
      - 'null'
      - string
    doc: Type of BLAST search
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blast2galaxy:1.0.0--pyhdfd78af_0
stdout: blast2galaxy_list-tools.out
