cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - capability
label: apptainer_capability
doc: "Manage Linux capabilities for users and groups. Capabilities allow you to have
  fine grained control over the permissions that your containers need to run.\n\n
  Tool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: command
    type: string
    doc: 'The capability command to execute: add (Add capabilities), avail (Show description
      for available capabilities), drop (Remove capabilities), or list (Show capabilities
      for a given user or group).'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_capability.out
