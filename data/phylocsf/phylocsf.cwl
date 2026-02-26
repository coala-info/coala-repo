cwlVersion: v1.2
class: CommandLineTool
baseCommand: PhyloCSF
label: phylocsf
doc: "PhyloCSF (Phylogenetic Codon Substitution Frequencies) is a tool to identify
  protein-coding regions in a genome alignment using a comparative genomics approach.\n\
  \nTool homepage: https://github.com/mlin/PhyloCSF/wiki"
inputs:
  - id: strategy
    type: string
    doc: The strategy to use (e.g., fixed, empirical, omega, search, or hmm)
    inputBinding:
      position: 1
  - id: alignment_file
    type: File
    doc: Input alignment file
    inputBinding:
      position: 2
  - id: frames
    type:
      - 'null'
      - int
    doc: Number of frames to analyze (1, 3, or 6)
    inputBinding:
      position: 103
      prefix: --frames
  - id: remove_gaps
    type:
      - 'null'
      - boolean
    doc: Remove columns with gaps in the alignment
    inputBinding:
      position: 103
      prefix: --remove-gaps
  - id: species
    type:
      - 'null'
      - string
    doc: Comma-separated list of species to include
    inputBinding:
      position: 103
      prefix: --species
  - id: tree
    type:
      - 'null'
      - File
    doc: Newick tree file to use for the phylogeny
    inputBinding:
      position: 103
      prefix: --tree
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: File to write the output to
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylocsf:1.0.1--h3eba124_0
