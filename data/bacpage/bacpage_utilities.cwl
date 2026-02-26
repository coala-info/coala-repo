cwlVersion: v1.2
class: CommandLineTool
baseCommand: bacpage utilities
label: bacpage_utilities
doc: "Available utilities:\n  One of the following utilities must be specified:\n\n\
  Tool homepage: https://github.com/CholGen/bacpage"
inputs:
  - id: utility
    type: string
    doc: One of the following utilities must be specified
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bacpage:2025.08.21--pyhdfd78af_0
stdout: bacpage_utilities.out
