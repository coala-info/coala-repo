cwlVersion: v1.2
class: CommandLineTool
baseCommand: mammal
label: mammal
doc: "A tool for DNA methylation analysis (Note: The provided help text contains only
  container runtime error logs and does not list specific command-line arguments).\n
  \nTool homepage: https://www.mathstat.dal.ca/~tsusko/doc/mammal.pdf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mammal:1.1.1--h503566f_3
stdout: mammal.out
