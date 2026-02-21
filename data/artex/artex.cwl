cwlVersion: v1.2
class: CommandLineTool
baseCommand: artex
label: artex
doc: "A tool for exon-level analysis (Note: The provided text is a container build
  error log and does not contain usage information or argument definitions).\n\nTool
  homepage: https://github.com/JMencius/Artex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artex:0.2.0--py39h9ee0642_0
stdout: artex.out
