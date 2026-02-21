cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - subscription
label: anchore-cli_subscription
doc: "Manage subscriptions for image analysis and policy updates in Anchore Engine.\n
  \nTool homepage: https://github.com/anchore/anchore-cli"
inputs:
  - id: command
    type: string
    doc: The subscription command to execute (e.g., list, activate, deactivate).
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the subscription command.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_subscription.out
