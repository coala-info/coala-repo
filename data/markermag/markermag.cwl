cwlVersion: v1.2
class: CommandLineTool
baseCommand: markermag
label: markermag
doc: "A tool for marker-based genome analysis (Note: The provided text contains only
  container runtime error logs and no help documentation; therefore, no arguments
  could be extracted).\n\nTool homepage: https://pypi.org/project/MarkerMAG/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/markermag:1.1.28--pyh7cba7a3_0
stdout: markermag.out
