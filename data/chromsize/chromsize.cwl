cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromsize
label: chromsize
doc: "A tool for handling or retrieving chromosome sizes (Note: The provided text
  contains system error logs rather than help documentation, so specific arguments
  could not be extracted).\n\nTool homepage: https://github.com/alejandrogzi/chromsize"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromsize:0.0.32--ha6fb395_0
stdout: chromsize.out
