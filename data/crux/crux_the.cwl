cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux
label: crux_the
doc: "Crux is a suite of tools for analyzing mass spectrometry data.\n\nTool homepage:
  https://github.com/redbadger/crux"
inputs:
  - id: command
    type: string
    doc: The primary or utility command to run.
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options specific to the chosen command.
    inputBinding:
      position: 2
  - id: argument
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments specific to the chosen command.
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_the.out
