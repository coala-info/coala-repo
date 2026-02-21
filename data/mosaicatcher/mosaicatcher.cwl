cwlVersion: v1.2
class: CommandLineTool
baseCommand: mosaicatcher
label: mosaicatcher
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error regarding container image building (no space left
  on device).\n\nTool homepage: https://github.com/friendsofstrandseq/mosaicatcher/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mosaicatcher:0.3.1--h5642b88_3
stdout: mosaicatcher.out
