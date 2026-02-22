cwlVersion: v1.2
class: CommandLineTool
baseCommand: pilea
label: pilea
doc: "A tool for processing pileup files (Note: The provided text contains system
  error logs rather than help documentation, so specific arguments and descriptions
  could not be extracted).\n\nTool homepage: https://github.com/xinehc/pilea"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pilea:1.3.7--py312h4711d71_0
stdout: pilea.out
