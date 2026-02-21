cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnaredprint
label: rnaredprint
doc: "A tool for RNA design (RedPrint). Note: The provided input text contains container
  runtime error logs rather than the tool's help documentation, so no arguments could
  be extracted.\n\nTool homepage: https://github.com/yannponty/RNARedPrint"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaredprint:0.3--h9948957_2
stdout: rnaredprint.out
