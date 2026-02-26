cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gofasta
  - completion
label: gofasta_completion
doc: "Generate the autocompletion script for gofasta for the specified shell.\n\n\
  Tool homepage: https://github.com/cov-ert/gofasta"
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: The shell for which to generate the autocompletion script (bash, fish, 
      powershell, zsh)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gofasta:1.2.3--h9ee0642_0
stdout: gofasta_completion.out
