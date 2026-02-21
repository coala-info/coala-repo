cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylocsf++
label: phylocsfpp_phylocsf++
doc: "PhyloCSF++ is a tool for identifying protein-coding regions using comparative
  genomics. (Note: The provided text contains container build errors rather than help
  documentation; no arguments could be extracted.)\n\nTool homepage: https://github.com/cpockrandt/PhyloCSFpp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylocsfpp:1.2.0_9643238d--hea07040_3
stdout: phylocsfpp_phylocsf++.out
