cwlVersion: v1.2
class: CommandLineTool
baseCommand: dcplib
label: dcplib
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding a container build failure
  (no space left on device).\n\nTool homepage: http://github.com/HumanCellAtlas/dcplib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dcplib:3.12.0--py_0
stdout: dcplib.out
