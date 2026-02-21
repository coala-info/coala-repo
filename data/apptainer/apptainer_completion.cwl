cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - completion
label: apptainer_completion
doc: "Generate the autocompletion script for apptainer for the specified shell.\n\n
  Tool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: shell
    type: string
    doc: The shell for which to generate the autocompletion script (bash, fish, powershell,
      or zsh)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
stdout: apptainer_completion.out
