cwlVersion: v1.2
class: CommandLineTool
baseCommand: maelstrom-core
label: maelstrom-core
doc: "Tools for processing of NGS data\n\nTool homepage: https://github.com/bihealth/maelstrom-core"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to run
    inputBinding:
      position: 1
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Less output per occurrence
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: More output per occurrence
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maelstrom-core:0.1.1--he3973ca_3
stdout: maelstrom-core.out
