cwlVersion: v1.2
class: CommandLineTool
baseCommand: crisprbact
label: crisprbact
doc: "A command-line tool for CRISPR analysis in bacteria.\n\nTool homepage: https://gitlab.pasteur.fr/dbikard/crisprbact"
inputs:
  - id: command
    type: string
    doc: The subcommand to execute
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crisprbact:0.3.11--py_0
stdout: crisprbact.out
