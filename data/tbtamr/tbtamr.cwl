cwlVersion: v1.2
class: CommandLineTool
baseCommand: tbtamr
label: tbtamr
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build/fetch process.\n\nTool
  homepage: https://github.com/MDU-PHL/tbtamr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tbtamr:1.0.3--pyhdfd78af_0
stdout: tbtamr.out
