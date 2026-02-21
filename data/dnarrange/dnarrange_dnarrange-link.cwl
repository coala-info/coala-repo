cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dnarrange
  - link
label: dnarrange_dnarrange-link
doc: "A tool for linking DNA rearrangements (Note: The provided help text contains
  only container runtime error messages and no usage information).\n\nTool homepage:
  https://github.com/mcfrith/dnarrange"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnarrange:1.6.3--pyh7e72e81_0
stdout: dnarrange_dnarrange-link.out
