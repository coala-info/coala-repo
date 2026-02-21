cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacompass
label: metacompass
doc: "MetaCompass is a software package for comparative assembly of metagenomic reads.\n
  \nTool homepage: https://github.com/marbl/MetaCompass"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacompass:1.12--h9948957_0
stdout: metacompass.out
