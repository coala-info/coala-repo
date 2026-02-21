cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtfsort
label: gtfsort
doc: "A tool for sorting GTF files (Note: The provided text contains container runtime
  error messages rather than the tool's help documentation).\n\nTool homepage: https://github.com/alejandrogzi/gtfsort"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtfsort:0.2.2--ha6fb395_2
stdout: gtfsort.out
