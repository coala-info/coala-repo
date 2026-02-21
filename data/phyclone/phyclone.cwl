cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyclone
label: phyclone
doc: "PhyClone is a tool for phylogenetic clustering of subclonal populations.\n\n
  Tool homepage: https://github.com/Roth-Lab/PhyClone"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyclone:0.8.0--pyhdfd78af_0
stdout: phyclone.out
