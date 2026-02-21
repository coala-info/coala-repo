cwlVersion: v1.2
class: CommandLineTool
baseCommand: sarscov2summary
label: sarscov2summary
doc: "A tool for summarizing SARS-CoV-2 data. (Note: The provided text contains container
  build logs and error messages rather than command-line help documentation; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/nickeener/sarscov2formatter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sarscov2summary:0.5--py_1
stdout: sarscov2summary.out
