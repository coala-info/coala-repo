cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux
label: crux_for
doc: "Crux is a suite of tools for analyzing tandem mass spectrometry data.\n\nTool
  homepage: https://github.com/redbadger/crux"
inputs:
  - id: command
    type: string
    doc: The specific Crux command to execute. Available commands are listed 
      below.
    inputBinding:
      position: 1
  - id: argument
    type:
      - 'null'
      - string
    doc: Arguments specific to the chosen command.
    inputBinding:
      position: 2
  - id: options
    type:
      - 'null'
      - string
    doc: Options specific to the chosen command.
    inputBinding:
      position: 103
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_for.out
