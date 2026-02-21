cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylocsf
label: phylocsf
doc: "PhyloCSF (Phylogenetic Codon Substitution Frequencies) is a method to determine
  whether a multi-species nucleotide sequence alignment is likely to represent a protein-coding
  region.\n\nTool homepage: https://github.com/mlin/PhyloCSF/wiki"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylocsf:1.0.1--h3eba124_0
stdout: phylocsf.out
