cwlVersion: v1.2
class: CommandLineTool
baseCommand: edittag
label: edittag
doc: "A tool for editing tags in sequencing data (Note: The provided text is a system
  error message and does not contain help documentation or argument definitions).\n
  \nTool homepage: https://github.com/qiugang/EditTag"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/edittag:1.1--py35_1
stdout: edittag.out
