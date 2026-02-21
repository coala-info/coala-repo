cwlVersion: v1.2
class: CommandLineTool
baseCommand: sorted_nearest
label: sorted_nearest
doc: "A tool for finding the nearest intervals in sorted genomic files (Note: The
  provided text contains container build logs and error messages rather than help
  text, so no arguments could be extracted).\n\nTool homepage: https://github.com/endrebak/sorted_nearest"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sorted_nearest:0.0.41--py312h0fa9677_0
stdout: sorted_nearest.out
