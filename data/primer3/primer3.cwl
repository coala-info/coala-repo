cwlVersion: v1.2
class: CommandLineTool
baseCommand: primer3
label: primer3
doc: "Primer3 is a tool for designing PCR primers. (Note: The provided text is a container
  execution error log and does not contain help documentation or argument definitions.)\n
  \nTool homepage: https://github.com/primer3-org/primer3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primer3:2.6.1--pl5321h503566f_7
stdout: primer3.out
