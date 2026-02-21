cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - query
label: anchore-cli_query
doc: "Query system for images based on packages or vulnerabilities\n\nTool homepage:
  https://github.com/anchore/anchore-cli"
inputs:
  - id: command
    type: string
    doc: The query command to execute (images-by-package or images-by-vulnerability)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the query command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_query.out
