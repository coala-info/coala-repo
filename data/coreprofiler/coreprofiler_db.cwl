cwlVersion: v1.2
class: CommandLineTool
baseCommand: coreprofiler db
label: coreprofiler_db
doc: "Database handling specific arguments.\n\nTool homepage: https://gitlab.com/ifb-elixirfr/abromics"
inputs:
  - id: subcommand
    type: string
    doc: Functions of database mode.
    inputBinding:
      position: 1
  - id: available_schemes
    type:
      - 'null'
      - boolean
    doc: List available schemes.
    inputBinding:
      position: 102
      prefix: --available_schemes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreprofiler:2.0.0--pyhdfd78af_0
stdout: coreprofiler_db.out
