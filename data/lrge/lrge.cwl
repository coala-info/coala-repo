cwlVersion: v1.2
class: CommandLineTool
baseCommand: lrge
label: lrge
doc: "Long-read gene expression analysis tool. (Note: The provided text is a container
  runtime error message and does not contain the tool's help documentation or argument
  definitions.)\n\nTool homepage: https://github.com/mbhall88/lrge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrge:0.2.1--h9f13da3_0
stdout: lrge.out
