cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylorank
  - decorate
label: phylorank_decorate
doc: "Place internal taxonomic labels on tree.\n\nTool homepage: https://github.com/dparks1134/PhyloRank"
inputs:
  - id: input_tree
    type: File
    doc: tree to decorate
    inputBinding:
      position: 1
  - id: taxonomy_file
    type: File
    doc: file indicating taxonomy of extant taxa
    inputBinding:
      position: 2
  - id: gtdb_metadata
    type:
      - 'null'
      - File
    doc: GTDB metadata file (used to resolve ambiguous cases)
    inputBinding:
      position: 103
      prefix: --gtdb_metadata
  - id: min_children
    type:
      - 'null'
      - int
    doc: minimum required child taxa to consider taxa when inferring distribution
    inputBinding:
      position: 103
      prefix: --min_children
  - id: min_support
    type:
      - 'null'
      - float
    doc: minimum support value to consider taxa when inferring distribution
    inputBinding:
      position: 103
      prefix: --min_support
  - id: skip_rd_refine
    type:
      - 'null'
      - boolean
    doc: skip refinement of taxonomy based on relative divergence information
    inputBinding:
      position: 103
      prefix: --skip_rd_refine
  - id: skip_species
    type:
      - 'null'
      - boolean
    doc: skip decoration of species
    inputBinding:
      position: 103
      prefix: --skip_species
  - id: trusted_taxa_file
    type:
      - 'null'
      - File
    doc: 'file indicating trusted taxonomic groups to use for inferring distribution
      (default: all taxa)'
    inputBinding:
      position: 103
      prefix: --trusted_taxa_file
  - id: viral
    type:
      - 'null'
      - boolean
    doc: indicates a viral input tree and taxonomy
    inputBinding:
      position: 103
      prefix: --viral
outputs:
  - id: output_tree
    type: File
    doc: decorated tree
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
