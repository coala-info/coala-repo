cwlVersion: v1.2
class: CommandLineTool
baseCommand: data_hacks
label: data_hacks
doc: "A collection of command line tools for data analysis. Note: The provided input
  text contains system error logs regarding a failed container build and does not
  list specific command-line arguments.\n\nTool homepage: https://github.com/bitly/data_hacks"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/data_hacks:0.3.1--py27_0
stdout: data_hacks.out
