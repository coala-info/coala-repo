cwlVersion: v1.2
class: CommandLineTool
baseCommand: structure
label: structure
doc: "A software package for multi-locus genotype data to investigate population structure.\n
  \nTool homepage: https://web.stanford.edu/group/pritchardlab/structure.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/structure:2.3.4--h7b50bb2_7
stdout: structure.out
