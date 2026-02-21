cwlVersion: v1.2
class: CommandLineTool
baseCommand: asciigenome
label: asciigenome
doc: "ASCIIGenome is a command line genome browser for the console terminal.\n\nTool
  homepage: https://github.com/dariober/ASCIIGenome"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/asciigenome:1.19.0--hdfd78af_0
stdout: asciigenome.out
