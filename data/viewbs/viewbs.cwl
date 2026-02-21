cwlVersion: v1.2
class: CommandLineTool
baseCommand: viewbs
label: viewbs
doc: "A toolkit for visualization of bisulfite sequencing data (Note: The provided
  text contains system logs and error messages rather than the tool's help documentation,
  so no arguments could be extracted).\n\nTool homepage: https://github.com/xie186/ViewBS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viewbs:0.1.11--pl5321h7b50bb2_4
stdout: viewbs.out
