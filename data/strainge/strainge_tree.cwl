cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainge tree
label: strainge_tree
doc: "Build an approximate phylogenetic tree based on a given distance matrix, using
  neighbour joining.\nBecause our pairwise distances are pretty rough (especially
  at lower coverages), the triangle inequality may not hold, and the resulting tree
  may not be accurate.\n\nTool homepage: The package home page"
inputs:
  - id: distance_matrix
    type: File
    doc: The path to the distance matrix TSV, as created by `straingr dist`.
    inputBinding:
      position: 1
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output filename.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
