cwlVersion: v1.2
class: CommandLineTool
baseCommand: slncky
label: slncky
doc: "The provided text does not contain help information or a description for the
  tool 'slncky'. It appears to be a log of a failed container build/execution process.\n
  \nTool homepage: https://github.com/slncky/slncky"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slncky:1.0.4--1
stdout: slncky.out
