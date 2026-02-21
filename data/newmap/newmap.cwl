cwlVersion: v1.2
class: CommandLineTool
baseCommand: newmap
label: newmap
doc: "The provided text contains error logs and environment information rather than
  tool help text. No arguments or usage instructions could be extracted from the input.\n
  \nTool homepage: https://github.com/hoffmangroup/newmap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/newmap:0.2--py312h9c9b0c2_1
stdout: newmap.out
