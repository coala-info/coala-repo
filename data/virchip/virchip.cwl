cwlVersion: v1.2
class: CommandLineTool
baseCommand: virchip
label: virchip
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build/fetch process.\n\nTool
  homepage: https://virchip.hoffmanlab.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virchip:1.2.2--py_0
stdout: virchip.out
