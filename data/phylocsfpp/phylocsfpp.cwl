cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylocsfpp
label: phylocsfpp
doc: "PhyloCSF++ is a tool for identifying protein-coding regions. (Note: The provided
  text contains container execution errors rather than tool help documentation, so
  no arguments could be extracted.)\n\nTool homepage: https://github.com/cpockrandt/PhyloCSFpp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylocsfpp:1.2.0_9643238d--hea07040_3
stdout: phylocsfpp.out
