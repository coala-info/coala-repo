cwlVersion: v1.2
class: CommandLineTool
baseCommand: spread-phy
label: spread-phy
doc: "Spatial Phylogenetic Reconstruction of Evolutionary Dynamics. (Note: The provided
  text contains container runtime error logs rather than tool help text; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/KaleyWhite/med-phys-spreadsheets"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/spread-phy:v1.0.7dfsg-2-deb_cv1
stdout: spread-phy.out
