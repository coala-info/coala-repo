cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gof3r
label: s3gof3r_gof3r
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container build process.\n\nTool homepage: https://github.com/rlmcpherson/s3gof3r"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/s3gof3r:0.5.0--1
stdout: s3gof3r_gof3r.out
