cwlVersion: v1.2
class: CommandLineTool
baseCommand: data_hacks_ninety_five_percent.py
label: data_hacks_ninety_five_percent.py
doc: "A tool from the data_hacks collection used to calculate the 95th percentile
  of input data. (Note: The provided help text contains only system error logs and
  no argument definitions.)\n\nTool homepage: https://github.com/bitly/data_hacks"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/data_hacks:0.3.1--py27_0
stdout: data_hacks_ninety_five_percent.py.out
