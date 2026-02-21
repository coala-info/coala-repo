cwlVersion: v1.2
class: CommandLineTool
baseCommand: clair3
label: clair3
doc: "Clair3 is a germline small variant caller for long-read sequencing. (Note: The
  provided text contains system error logs rather than help documentation; no arguments
  could be extracted from the input.)\n\nTool homepage: https://github.com/HKU-BAL/Clair3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair3:1.2.0--py310h779eee5_0
stdout: clair3.out
