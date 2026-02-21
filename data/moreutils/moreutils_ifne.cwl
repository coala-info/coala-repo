cwlVersion: v1.2
class: CommandLineTool
baseCommand: ifne
label: moreutils_ifne
doc: "Run a command if the standard input is not empty (or empty with -n).\n\nTool
  homepage: https://github.com/madx/moreutils"
inputs:
  - id: command
    type: string
    doc: The command to be executed.
    inputBinding:
      position: 1
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments to be passed to the command.
    inputBinding:
      position: 2
  - id: reverse_condition
    type:
      - 'null'
      - boolean
    doc: 'Reverse the operation: run the command if the standard input is empty.'
    inputBinding:
      position: 103
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moreutils:0.5.7--1
stdout: moreutils_ifne.out
