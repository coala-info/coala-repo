cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - system
label: anchore-cli_system
doc: "Anchore engine system operations including status checks, feed management, and
  service deletion.\n\nTool homepage: https://github.com/anchore/anchore-cli"
inputs:
  - id: command
    type: string
    doc: The system command to execute (del, errorcodes, feeds, status, wait)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for the specific system command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_system.out
