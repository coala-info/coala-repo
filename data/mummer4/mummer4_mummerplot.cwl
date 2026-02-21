cwlVersion: v1.2
class: CommandLineTool
baseCommand: mummerplot
label: mummer4_mummerplot
doc: "A utility for generating dotplots from MUMmer alignments. (Note: The provided
  help text contains only system error messages and no usage information; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://mummer4.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_mummerplot.out
