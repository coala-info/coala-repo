cwlVersion: v1.2
class: CommandLineTool
baseCommand: bottle
label: bottle
doc: "The provided text does not contain help information or a description of the
  tool; it consists of system error messages related to container image conversion
  and disk space issues.\n\nTool homepage: https://github.com/bottlerocket-os/bottlerocket"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bottle:0.12.9--py35_0
stdout: bottle.out
