cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffindex-dbkit
label: ffindex-dbkit
doc: "The provided text contains system error messages related to a container environment
  failure and does not include the tool's help documentation or usage instructions.\n
  \nTool homepage: https://github.com/guerler/spring"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ffindex-dbkit:0.2--pyh5e36f6f_2
stdout: ffindex-dbkit.out
