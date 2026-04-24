cwlVersion: v1.2
class: CommandLineTool
baseCommand: mp3treesim
label: mp3treesim
doc: "MP3TreeSim: Multi-Phylogeny Perspective Proximity Tree Similarity. A tool to
  compute the similarity between two phylogenetic trees using the MP3 metric or other
  methods.\n\nTool homepage: https://algolab.github.io/mp3treesim/"
inputs:
  - id: labels
    type:
      - 'null'
      - File
    doc: File containing a list of labels to consider
    inputBinding:
      position: 101
      prefix: --labels
  - id: method
    type:
      - 'null'
      - string
    doc: Similarity method to use (e.g., mp3, grf, rf)
    inputBinding:
      position: 101
      prefix: --method
  - id: tree1
    type: File
    doc: First input tree file
    inputBinding:
      position: 101
      prefix: --tree1
  - id: tree2
    type: File
    doc: Second input tree file
    inputBinding:
      position: 101
      prefix: --tree2
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to write the similarity results
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mp3treesim:1.0.6--py_0
