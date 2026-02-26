cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnaapler
label: dnaapler_initiation
doc: "A tool for analyzing DNA sequences.\n\nTool homepage: https://github.com/gbouras13/dnaapler"
inputs:
  - id: command
    type: string
    doc: The command to execute.
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnaapler:1.3.0--pyhdfd78af_0
stdout: dnaapler_initiation.out
