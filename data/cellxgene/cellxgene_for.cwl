cwlVersion: v1.2
class: CommandLineTool
baseCommand: cellxgene
label: cellxgene_for
doc: "Command-line interface for cellxgene\n\nTool homepage: https://chanzuckerberg.github.io/cellxgene/"
inputs:
  - id: command
    type: string
    doc: The command to execute
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
  - id: options
    type:
      - 'null'
      - string
    doc: General options for cellxgene
    inputBinding:
      position: 103
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellxgene:1.3.0--pyhdfd78af_0
stdout: cellxgene_for.out
