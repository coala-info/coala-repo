cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - config
label: apptainer_config
doc: "Manage various apptainer configuration (root user only). The config command
  allows root user to manage various configuration like fakeroot user mapping entries.\n
  \nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: command
    type: string
    doc: The configuration command to execute (fakeroot or global)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_config.out
