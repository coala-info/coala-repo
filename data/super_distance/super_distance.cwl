cwlVersion: v1.2
class: CommandLineTool
baseCommand: super_distance
label: super_distance
doc: "Matrix Representation with Distances: calculates pairwise distances between
  gene leaves, and estimates species trees from summary distance matrices\n\nTool
  homepage: https://github.com/quadram-institute-bioscience/super_distance"
inputs:
  - id: gene_tree_files
    type:
      type: array
      items: File
    doc: list of gene tree files, in newick format
    inputBinding:
      position: 1
  - id: epsilon
    type:
      - 'null'
      - float
    doc: tolerance (small value below which a branch length is considered zero 
      for nodal distances)
    inputBinding:
      position: 102
      prefix: --epsilon
  - id: fast
    type:
      - 'null'
      - boolean
    doc: for too many leaves, estimates only two species trees
    inputBinding:
      position: 102
      prefix: --fast
  - id: species_names_file
    type:
      - 'null'
      - File
    doc: file with species names, one per line (comments in square braces 
      allowed); if absent, orthology is assumed
    inputBinding:
      position: 102
      prefix: --species
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file with species supertrees, in newick format (default '-')
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/super_distance:1.1.0--h577a1d6_6
