cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - policy
label: anchore-cli_policy
doc: "Manage and interact with Anchore policies\n\nTool homepage: https://github.com/anchore/anchore-cli"
inputs:
  - id: command
    type: string
    doc: The policy command to execute (activate, add, del, describe, get, hub, list)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specific policy command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_policy.out
