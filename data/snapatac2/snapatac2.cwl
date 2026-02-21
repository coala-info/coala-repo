cwlVersion: v1.2
class: CommandLineTool
baseCommand: snapatac2
label: snapatac2
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build/fetch process.\n\nTool
  homepage: https://github.com/kaizhang/SnapATAC2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snapatac2:2.8.0--py310h9e9ef0c_1
stdout: snapatac2.out
