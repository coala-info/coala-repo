cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylorank
  - bl_dist
label: phylorank_bl_dist
doc: "Calculate distribution of branch lengths at each taxonomic rank.\n\nTool homepage:
  https://github.com/dparks1134/PhyloRank"
inputs:
  - id: input_tree
    type: File
    doc: input tree to calculate branch length distributions
    inputBinding:
      position: 1
  - id: min_children
    type:
      - 'null'
      - int
    doc: minimum required child taxa to consider taxa when inferring distribution
    default: 2
    inputBinding:
      position: 102
      prefix: --min_children
  - id: taxonomy_file
    type:
      - 'null'
      - File
    doc: read taxonomy from this file instead of directly from tree
    inputBinding:
      position: 102
      prefix: --taxonomy_file
  - id: trusted_taxa_file
    type:
      - 'null'
      - File
    doc: 'file indicating trusted taxonomic groups to use for inferring distribution
      (default: all taxa)'
    inputBinding:
      position: 102
      prefix: --trusted_taxa_file
outputs:
  - id: output_dir
    type: Directory
    doc: desired output directory for generated files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
