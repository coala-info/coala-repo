cwlVersion: v1.2
class: CommandLineTool
baseCommand: gotree_annotate
label: gotree_annotate
doc: "Annotates internal branches of a tree with given data.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: comment
    type:
      - 'null'
      - boolean
    doc: Annotations are stored in Newick comment fields
    inputBinding:
      position: 101
      prefix: --comment
  - id: compared_tree_file
    type:
      - 'null'
      - File
    doc: Compared tree file
    default: stdin
    inputBinding:
      position: 101
      prefix: --compared
  - id: input_tree_file
    type:
      - 'null'
      - File
    doc: Input tree(s) file
    default: stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: input_tree_format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain)
    default: newick
    inputBinding:
      position: 101
      prefix: --format
  - id: map_file
    type:
      - 'null'
      - File
    doc: Name map input file
    default: none
    inputBinding:
      position: 101
      prefix: --map-file
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Random Seed: -1 = nano seconds since 1970/01/01 00:00:00'
    default: -1
    inputBinding:
      position: 101
      prefix: --seed
  - id: subtrees
    type:
      - 'null'
      - boolean
    doc: Annotate the internal node and all descending intern nodes with the 
      given annotations
    inputBinding:
      position: 101
      prefix: --subtrees
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (Max=20)
    default: 1
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Resolved tree(s) output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
