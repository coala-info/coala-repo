cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpp-popgen
label: bpp-popgen
doc: "Bio++ Population Genetics tool (Note: The provided text contains system error
  messages rather than the tool's help documentation, so arguments could not be extracted).\n\
  \nTool homepage: https://github.com/BioPP/bpp-popgen"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bpp-popgen:2.4.1--h9948957_5
stdout: bpp-popgen.out
