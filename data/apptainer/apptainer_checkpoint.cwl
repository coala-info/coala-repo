cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - checkpoint
label: apptainer_checkpoint
doc: "Manage container checkpoint state (experimental)\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: subcommand
    type: string
    doc: The checkpoint subcommand to execute (create, delete, instance, or list)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_checkpoint.out
