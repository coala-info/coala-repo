cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux
label: crux_corresponding
doc: "Supports a variety of commands for mass spectrometry data analysis.\n\nTool
  homepage: https://github.com/redbadger/crux"
inputs:
  - id: command
    type: string
    doc: The primary or utility command to execute.
    inputBinding:
      position: 1
  - id: argument
    type:
      - 'null'
      - string
    doc: Arguments specific to the chosen command.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_corresponding.out
