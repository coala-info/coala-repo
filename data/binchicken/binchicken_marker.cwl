cwlVersion: v1.2
class: CommandLineTool
baseCommand: binchicken
label: binchicken_marker
doc: "A command-line tool for binning chicken genomes.\n\nTool homepage: https://github.com/aroneys/binchicken"
inputs:
  - id: subparser_name
    type: string
    doc: The subcommand to run. Choose from 'coassemble', 'single', 'evaluate', 
      'update', 'iterate', 'build'.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/binchicken:0.13.5--pyhdfd78af_0
stdout: binchicken_marker.out
