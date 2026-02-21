cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphbin
label: graphbin
doc: "GraphBin is a tool for refining metagenomic bins using assembly graphs. (Note:
  The provided help text contains only system error messages and no usage information;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/Vini2/GraphBin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphbin:1.7.4--pyhdfd78af_0
stdout: graphbin.out
