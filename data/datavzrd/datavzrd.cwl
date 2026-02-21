cwlVersion: v1.2
class: CommandLineTool
baseCommand: datavzrd
label: datavzrd
doc: "A tool for creating visual reports from tabular data (Note: The provided text
  contains container runtime error logs rather than the tool's help documentation).\n
  \nTool homepage: https://github.com/datavzrd/datavzrd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datavzrd:2.23.2
stdout: datavzrd.out
