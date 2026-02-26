cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - cell
label: datafunk_cell
doc: "Subcommand for datafunk. The provided 'cell' is not a valid subcommand. Please
  choose from the available subcommands.\n\nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to run. 'cell' is not a valid choice.
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
stdout: datafunk_cell.out
