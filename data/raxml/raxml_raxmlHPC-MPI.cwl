cwlVersion: v1.2
class: CommandLineTool
baseCommand: raxmlHPC-MPI
label: raxml_raxmlHPC-MPI
doc: "RAxML (Randomized Axelerated Maximum Likelihood) is a tool for phylogenetic
  analysis. (Note: The provided text contains container runtime error messages rather
  than the tool's help documentation.)\n\nTool homepage: http://sco.h-its.org/exelixis/web/software/raxml/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raxml:8.2.13--h7b50bb2_3
stdout: raxml_raxmlHPC-MPI.out
