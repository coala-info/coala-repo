cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccp4srs
label: ccp4srs
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to extract a container image due to
  insufficient disk space.\n\nTool homepage: https://www.ccp4.ac.uk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccp4srs:2024.06.14--h077b44d_0
stdout: ccp4srs.out
