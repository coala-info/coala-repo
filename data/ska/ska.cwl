cwlVersion: v1.2
class: CommandLineTool
baseCommand: ska
label: ska
doc: "Split K-mer Analysis (SKA) toolkit for genomic data. Note: The provided text
  appears to be a container build error log rather than help text, so no arguments
  could be extracted.\n\nTool homepage: https://github.com/simonrharris/SKA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska:1.0--h077b44d_7
stdout: ska.out
