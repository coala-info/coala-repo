cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpp-phyl
label: bpp-phyl
doc: "Bio++ Phylogenetic library tool (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/BioPP/bpp-phyl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bpp-phyl:2.4.1--h9948957_5
stdout: bpp-phyl.out
