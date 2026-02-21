cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - anchore-cli
  - account
label: anchore-cli_account
doc: "Account management operations for Anchore CLI, including adding, deleting, and
  managing account status and users.\n\nTool homepage: https://github.com/anchore/anchore-cli"
inputs:
  - id: command
    type: string
    doc: The account command to execute (add, del, disable, enable, get, list, user,
      whoami)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified account command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/anchore-cli:latest
stdout: anchore-cli_account.out
