cwlVersion: v1.2
class: CommandLineTool
baseCommand: unikmer
label: unikmer
doc: "A toolkit for k-mer based analysis (Note: The provided text contains only container
  build logs and no help information; arguments could not be extracted).\n\nTool homepage:
  https://github.com/shenwei356/unikmer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unikmer:0.20.0--h9ee0642_0
stdout: unikmer.out
