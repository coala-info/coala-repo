cwlVersion: v1.2
class: CommandLineTool
baseCommand: glean-gene
label: glean-gene
doc: "GLEAN (Gene Lattice Error-correcting Analysis Network) is a tool used to integrate
  evidence from multiple gene predictors into a single consensus set of gene models.\n
  \nTool homepage: https://sourceforge.net/projects/glean-gene/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glean-gene:1.0.1--hdfd78af_0
stdout: glean-gene.out
