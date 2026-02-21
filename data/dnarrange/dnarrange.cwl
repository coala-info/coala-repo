cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnarrange
label: dnarrange
doc: "A tool for genomic rearrangement analysis. (Note: The provided text contains
  container runtime error messages and does not include the actual help documentation
  or argument definitions.)\n\nTool homepage: https://github.com/mcfrith/dnarrange"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnarrange:1.6.3--pyh7e72e81_0
stdout: dnarrange.out
