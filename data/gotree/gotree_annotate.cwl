cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - annotate
label: gotree_annotate
doc: "Annotates internal branches of a tree with given data.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: comment
    type:
      - 'null'
      - boolean
    doc: "Annotations are stored in Newick comment fields"
    inputBinding:
      position: 101
      prefix: --comment
  - id: compared_tree
    type:
      - 'null'
      - File
    doc: "Compared tree file"
    inputBinding:
      position: 101
      prefix: --compared
  - id: input_tree
    type: File
    doc: "Input tree(s) file"
    inputBinding:
      position: 101
      prefix: --input
  - id: map_file
    type:
      - 'null'
      - File
    doc: "Name map input file"
    inputBinding:
      position: 101
      prefix: --map-file
  - id: output_file_path
    type: string
    doc: "Resolved tree(s) output file"
    inputBinding:
      position: 101
      prefix: --output
  - id: subtrees
    type:
      - 'null'
      - boolean
    doc: "Annotate the internal node and all descending intern nodes with the given annotations"
    inputBinding:
      position: 101
      prefix: --subtrees
  - id: tree_format
    type:
      - 'null'
      - string
    doc: "Input tree format (newick, nexus, phyloxml, or nextstrain)"
    inputBinding:
      position: 101
      prefix: --format
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random Seed: -1 = nano seconds since 1970/01/01 00:00:00"
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (Max=20)"
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type: File
    doc: "Output file written to the path in output_file_path"
    outputBinding:
      glob: "$(inputs.output_file_path)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
