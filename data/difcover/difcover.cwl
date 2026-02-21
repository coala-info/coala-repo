cwlVersion: v1.2
class: CommandLineTool
baseCommand: difcover
label: difcover
doc: "A tool for identifying genomic differences (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/timnat/DifCover"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/difcover:3.0.1--h9948957_2
stdout: difcover.out
