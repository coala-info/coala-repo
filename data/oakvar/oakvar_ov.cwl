cwlVersion: v1.2
class: CommandLineTool
baseCommand: ov
label: oakvar_ov
doc: "OakVar. Genomic variant analysis platform.\n\nTool homepage: http://www.oakvar.com"
inputs:
  - id: command
    type: string
    doc: Subcommand to execute
    inputBinding:
      position: 1
  - id: command_args
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
    dockerPull: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
stdout: oakvar_ov.out
