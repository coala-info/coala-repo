cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylocsf++
label: phylocsfpp_phylocsf++
doc: "A fast and easy-to-use tool to compute PhyloCSF scores and tracks and annotate
  GFF/GTF.\n\nTool homepage: https://github.com/cpockrandt/PhyloCSFpp"
inputs:
  - id: tool
    type: string
    doc: 'The tool to use. Available tools: build-tracks, score-msa, annotate-with-tracks,
      annotate-with-mmseqs, find-cds.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylocsfpp:1.2.0_9643238d--hea07040_3
stdout: phylocsfpp_phylocsf++.out
