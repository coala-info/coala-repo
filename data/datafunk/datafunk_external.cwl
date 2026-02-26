cwlVersion: v1.2
class: CommandLineTool
baseCommand: datafunk
label: datafunk_external
doc: "External subcommand for datafunk. The provided help text indicates an error
  and lists available subcommands.\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to execute. 'external' is not a valid choice.
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the chosen subcommand.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
stdout: datafunk_external.out
