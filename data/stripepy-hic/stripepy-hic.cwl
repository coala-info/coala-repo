cwlVersion: v1.2
class: CommandLineTool
baseCommand: stripepy-hic
label: stripepy-hic
doc: "A tool for detecting stripes in Hi-C data (Note: The provided help text contains
  only container build errors and no usage information).\n\nTool homepage: https://github.com/paulsengroup/StripePy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stripepy-hic:1.3.0--pyh2a3209d_1
stdout: stripepy-hic.out
