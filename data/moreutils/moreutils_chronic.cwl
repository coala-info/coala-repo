cwlVersion: v1.2
class: CommandLineTool
baseCommand: chronic
label: moreutils_chronic
doc: "Runs a command and hides its standard output and standard error unless the command
  fails (exits non-zero or crashes).\n\nTool homepage: https://github.com/madx/moreutils"
inputs:
  - id: command
    type: string
    doc: The command to execute.
    inputBinding:
      position: 1
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments to pass to the command.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moreutils:0.5.7--1
stdout: moreutils_chronic.out
