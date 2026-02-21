cwlVersion: v1.2
class: CommandLineTool
baseCommand: rdock
label: rdock
doc: "A fast and versatile open-source docking program for proteins and nucleic acids
  (Note: The provided text contained only system error messages and no help documentation;
  no arguments could be parsed).\n\nTool homepage: https://github.com/dvddarias/rdocker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rdock:2013.1-0
stdout: rdock.out
