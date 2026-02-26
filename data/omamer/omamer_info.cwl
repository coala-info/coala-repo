cwlVersion: v1.2
class: CommandLineTool
baseCommand: omamer_info
label: omamer_info
doc: "Show metadata about an existing omamer database\n\nTool homepage: https://github.com/DessimozLab/omamer"
inputs:
  - id: db
    type: string
    doc: Path to an existing database (including filename).
    inputBinding:
      position: 101
      prefix: --db
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/omamer:2.1.2--pyhdfd78af_0
stdout: omamer_info.out
