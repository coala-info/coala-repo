cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - evaluate
label: anchore-cli_evaluate
doc: "Evaluate images against policies using anchore-cli\n\nTool homepage: https://github.com/anchore/anchore-cli"
inputs:
  - id: command
    type: string
    doc: The command to execute under evaluate
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_evaluate.out
