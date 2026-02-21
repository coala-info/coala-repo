cwlVersion: v1.2
class: CommandLineTool
baseCommand: msaconverter
label: msaconverter
doc: "A tool for converting Multiple Sequence Alignment (MSA) files. (Note: The provided
  text contains system error logs rather than help documentation, so specific arguments
  could not be identified.)\n\nTool homepage: https://github.com/linzhi2013/msaconverter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msaconverter:0.0.4--pyhdfd78af_0
stdout: msaconverter.out
