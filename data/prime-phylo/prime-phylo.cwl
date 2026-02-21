cwlVersion: v1.2
class: CommandLineTool
baseCommand: prime-phylo
label: prime-phylo
doc: "A package for phylogenetic analysis (Note: The provided text contains only container
  build errors and no help documentation; no arguments could be extracted).\n\nTool
  homepage: https://github.com/gvMicroarctic/PhyloPrimer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/prime-phylo:v1.0.11-4b3-deb_cv1
stdout: prime-phylo.out
