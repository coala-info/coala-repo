cwlVersion: v1.2
class: CommandLineTool
baseCommand: straw
label: strawc_straw
doc: "A tool for fast data extraction from .hic files. (Note: The provided help text
  contains container runtime errors and does not list specific arguments.)\n\nTool
  homepage: https://github.com/aidenlab/straw"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strawc:0.0.2.1--py312h7de72ed_6
stdout: strawc_straw.out
