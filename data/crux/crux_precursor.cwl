cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux
label: crux_precursor
doc: "Crux is a suite of tools for analyzing mass spectrometry proteomics data.\n\n\
  Tool homepage: https://github.com/redbadger/crux"
inputs:
  - id: command
    type: string
    doc: The specific Crux command to execute. See 'crux help' for a list of 
      commands.
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Command-specific options.
    inputBinding:
      position: 2
  - id: argument
    type:
      - 'null'
      - type: array
        items: string
    doc: Command-specific arguments.
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_precursor.out
