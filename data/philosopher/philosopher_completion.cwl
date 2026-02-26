cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - philosopher
  - completion
label: philosopher_completion
doc: "Generate the autocompletion script for philosopher for the specified shell.\n\
  \nTool homepage: https://github.com/Nesvilab/philosopher"
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: The shell for which to generate the autocompletion script (e.g., bash, 
      fish, powershell, zsh)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/philosopher:5.1.2--he881be0_0
stdout: philosopher_completion.out
