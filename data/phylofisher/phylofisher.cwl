cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylofisher
label: phylofisher
doc: "PhyloFisher is a software package for phylogenomic analyses. (Note: The provided
  text contains system error messages regarding container execution and does not list
  specific CLI arguments.)\n\nTool homepage: https://github.com/TheBrownLab/PhyloFisher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylofisher:1.2.14--pyhdfd78af_0
stdout: phylofisher.out
