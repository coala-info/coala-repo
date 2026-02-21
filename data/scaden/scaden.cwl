cwlVersion: v1.2
class: CommandLineTool
baseCommand: scaden
label: scaden
doc: "Single-cell assisted deconvolution of bulk RNA-seq data (Note: The provided
  text contains only system logs and error messages, no help information was found
  to extract arguments).\n\nTool homepage: https://github.com/KevinMenden/scaden"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scaden:1.1.2--pyhdfd78af_0
stdout: scaden.out
