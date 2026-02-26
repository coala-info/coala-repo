cwlVersion: v1.2
class: CommandLineTool
baseCommand: noah
label: noah-cli_noah
doc: "A project management tool for reproducible, portable, and streamlined bioinformatics
  analysis.\n\nTool homepage: https://github.com/raymond-u/noah-cli"
inputs:
  - id: install_completion
    type:
      - 'null'
      - boolean
    doc: Install completion for the current shell.
    inputBinding:
      position: 101
      prefix: --install-completion
  - id: show_completion
    type:
      - 'null'
      - boolean
    doc: Show completion for the current shell, to copy it or customize the 
      installation.
    inputBinding:
      position: 101
      prefix: --show-completion
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/noah-cli:0.2.0--pyhdfd78af_0
stdout: noah-cli_noah.out
