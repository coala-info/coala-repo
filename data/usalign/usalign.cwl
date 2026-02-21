cwlVersion: v1.2
class: CommandLineTool
baseCommand: usalign
label: usalign
doc: "Universal structural alignment of proteins and nucleic acids. Note: The provided
  text contains system error logs and does not include the tool's help documentation
  or argument definitions.\n\nTool homepage: https://zhanggroup.org/US-align"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/usalign:20241201--h503566f_0
stdout: usalign.out
