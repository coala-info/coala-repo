cwlVersion: v1.2
class: CommandLineTool
baseCommand: arvados-cli
label: arvados-cli
doc: "Arvados command-line interface\n\nTool homepage: https://github.com/arvados/arvados-clients"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arvados-cli:0.1.20151207150126--0
stdout: arvados-cli.out
