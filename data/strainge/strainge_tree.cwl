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
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output filename.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
