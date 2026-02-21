cwlVersion: v1.2
class: CommandLineTool
baseCommand: treemaker
label: treemaker
doc: "The provided text is a container build error log and does not contain the tool's
  help documentation or usage instructions.\n\nTool homepage: https://github.com/SimonGreenhill/treemaker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treemaker:1.4--pyh9f0ad1d_0
stdout: treemaker.out
