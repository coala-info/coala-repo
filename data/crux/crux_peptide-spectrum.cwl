cwlVersion: v1.2
class: CommandLineTool
baseCommand: crux
label: crux_peptide-spectrum
doc: "Crux is a suite of tools for analyzing mass spectrometry proteomics data.\n\n\
  Tool homepage: https://github.com/redbadger/crux"
inputs:
  - id: command
    type: string
    doc: The Crux command to execute. Available commands are listed below.
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options and arguments specific to each command.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/crux:v3.2_cv3
stdout: crux_peptide-spectrum.out
