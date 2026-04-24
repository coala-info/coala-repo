cwlVersion: v1.2
class: CommandLineTool
baseCommand: parsinsert
label: parsinsert
doc: "Parsimonious Insertion of unclassified sequences into phylogenetic tree\n\n
  Tool homepage: https://github.com/dark2dark/parsinsert"
inputs:
  - id: insert_sequences
    type: File
    doc: Input sequences to be inserted into the tree
    inputBinding:
      position: 1
  - id: decimal_places
    type:
      - 'null'
      - int
    doc: 'print branch lengths using # decimal places'
    inputBinding:
      position: 102
      prefix: -D
  - id: mask_file
    type:
      - 'null'
      - File
    doc: read mask from this file
    inputBinding:
      position: 102
      prefix: -m
  - id: num_best_matches
    type:
      - 'null'
      - int
    doc: number of best matches to display
    inputBinding:
      position: 102
      prefix: -n
  - id: percent_threshold_cutoff
    type:
      - 'null'
      - float
    doc: percent threshold cutoff
    inputBinding:
      position: 102
      prefix: -c
  - id: print_node_comments
    type:
      - 'null'
      - boolean
    doc: print node comments in newick file
    inputBinding:
      position: 102
      prefix: -p
  - id: tree_file
    type:
      - 'null'
      - File
    doc: read core tree from this file
    inputBinding:
      position: 102
      prefix: -t
  - id: tree_sequences
    type:
      - 'null'
      - File
    doc: read core tree sequences from this file
    inputBinding:
      position: 102
      prefix: -s
  - id: tree_taxonomy
    type:
      - 'null'
      - File
    doc: read core tree taxomony from this file
    inputBinding:
      position: 102
      prefix: -x
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output taxonomy for each insert sequence to this file
    outputBinding:
      glob: $(inputs.output_file)
  - id: log_file
    type:
      - 'null'
      - File
    doc: create log file
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/parsinsert:v1.04-4-deb_cv1
