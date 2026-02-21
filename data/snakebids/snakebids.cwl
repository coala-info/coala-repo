cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakebids
label: snakebids
doc: "The provided text does not contain a description or usage information for the
  tool. It appears to be a log of a failed container build/fetch process.\n\nTool
  homepage: https://github.com/khanlab/snakebids"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakebids:0.15.0--pyhdfd78af_0
stdout: snakebids.out
