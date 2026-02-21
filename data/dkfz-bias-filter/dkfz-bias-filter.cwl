cwlVersion: v1.2
class: CommandLineTool
baseCommand: dkfz-bias-filter
label: dkfz-bias-filter
doc: 'A tool for filtering sequencing biases. (Note: The provided help text contains
  only system error messages and does not list specific command-line arguments.)'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dkfz-bias-filter:1.2.3a--py27_0
stdout: dkfz-bias-filter.out
