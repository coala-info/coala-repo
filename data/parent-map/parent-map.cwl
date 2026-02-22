cwlVersion: v1.2
class: CommandLineTool
baseCommand: parent-map
label: parent-map
doc: "A tool for parental mapping (Note: The provided text contains system error messages
  regarding disk space and container conversion rather than the tool's help documentation).\n\
  \nTool homepage: https://github.com/damienmarsic/parent-map"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/parent-map:1.1.2--pyhdfd78af_3
stdout: parent-map.out
