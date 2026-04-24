cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - matrix
label: gotree_matrix
doc: "Prints distance matrix associated to the input tree.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: average_matrices
    type:
      - 'null'
      - boolean
    doc: Average the distance matrices of all input trees
    inputBinding:
      position: 101
      prefix: --avg
  - id: input_tree
    type:
      - 'null'
      - File
    doc: Input tree
    inputBinding:
      position: 101
      prefix: --input
  - id: input_tree_format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain)
    inputBinding:
      position: 101
      prefix: --format
  - id: metric
    type:
      - 'null'
      - string
    doc: Distance metric (brlen|boot|none)
    inputBinding:
      position: 101
      prefix: --metric
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Random Seed: -1 = nano seconds since 1970/01/01 00:00:00'
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (Max=20)
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Matrix output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
