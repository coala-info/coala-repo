cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - image
label: anchore-cli_image
doc: "Manage images within Anchore CLI, including adding, analyzing, and retrieving
  vulnerability data.\n\nTool homepage: https://github.com/anchore/anchore-cli"
inputs:
  - id: command
    type: string
    doc: 'The command to execute: add, content, del, get, import, list, metadata,
      vuln, or wait'
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specific subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_image.out
