cwlVersion: v1.2
class: CommandLineTool
baseCommand: scitrack
label: scitrack
doc: "A tool for tracking scientific data provenance (Note: The provided text contains
  system error logs rather than help documentation, so no arguments could be extracted).\n\
  \nTool homepage: https://github.com/HuttleyLab/scitrack"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scitrack:2024.10.8--pyhdfd78af_0
stdout: scitrack.out
