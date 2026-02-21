cwlVersion: v1.2
class: CommandLineTool
baseCommand: repic
label: repic
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build/fetch process.\n\nTool
  homepage: https://github.com/ccameron/REPIC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repic:1.0.0--pyhdfd78af_0
stdout: repic.out
