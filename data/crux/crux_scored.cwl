cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux
label: crux_scored
doc: "Crux is a suite of tools for analyzing mass spectrometry proteomics data.\n\n\
  Tool homepage: https://github.com/redbadger/crux"
inputs:
  - id: command
    type: string
    doc: The specific Crux command to execute. See 'crux --help' for a list of 
      available commands.
    inputBinding:
      position: 1
  - id: argument
    type:
      - 'null'
      - type: array
        items: string
    doc: Command-specific arguments. Type 'crux <command> --help' for details on
      arguments for a specific command.
    inputBinding:
      position: 2
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Command-specific options. Type 'crux <command> --help' for details on 
      options for a specific command.
    inputBinding:
      position: 103
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_scored.out
