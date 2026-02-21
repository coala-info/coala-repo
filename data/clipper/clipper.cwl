cwlVersion: v1.2
class: CommandLineTool
baseCommand: clipper
label: clipper
doc: "The provided text does not contain help information or usage instructions. It
  contains error logs related to a container build failure (no space left on device).\n
  \nTool homepage: https://www.ccp4.ac.uk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clipper:2.1.20180802--hb2a3317_1
stdout: clipper.out
