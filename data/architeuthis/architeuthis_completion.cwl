cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - architeuthis
  - completion
label: architeuthis_completion
doc: "Generate the autocompletion script for the specified shell\n\nTool homepage:
  https://github.com/cdiener/architeuthis"
inputs:
  - id: shell
    type: string
    doc: The shell for which to generate the autocompletion script (bash, fish, powershell,
      or zsh)
    inputBinding:
      position: 1
  - id: db
    type:
      - 'null'
      - string
    doc: path to the Kraken database [optional]
    inputBinding:
      position: 102
      prefix: --db
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/architeuthis:0.5.0--he881be0_0
stdout: architeuthis_completion.out
