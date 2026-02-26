cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clusterfunk
  - label_transitions
label: clusterfunk_label_transitions
doc: "Label transitions of a trait on a phylogenetic tree and optionally output exploded
  trees for each transition.\n\nTool homepage: https://github.com/cov-ert/clusterfunk"
inputs:
  - id: collapse_to_polytomies
    type:
      - 'null'
      - float
    doc: A optional flag to collapse branches with length <= the input before 
      running the rule.
    inputBinding:
      position: 101
      prefix: --collapse_to_polytomies
  - id: exploded_trees
    type:
      - 'null'
      - boolean
    doc: A boolean flag to output a nexus for each transition. In this case the 
      ouput argument is treated as a directory and made if it doesn't exist
    inputBinding:
      position: 101
      prefix: --exploded_trees
  - id: format
    type:
      - 'null'
      - string
    doc: what format is the tree file. This is passed to dendropy. default is 
      'nexus'
    default: nexus
    inputBinding:
      position: 101
      prefix: --format
  - id: from_state
    type:
      - 'null'
      - string
    doc: Label transitions from this state. Can be combined with to.
    inputBinding:
      position: 101
      prefix: --from
  - id: include_parent
    type:
      - 'null'
      - boolean
    doc: A boolean flag to inlcude transition parent node in exploded trees
    inputBinding:
      position: 101
      prefix: --include_parent
  - id: input_tree
    type: File
    doc: The input tree file. Format can be specified with the format flag.
    inputBinding:
      position: 101
      prefix: --input
  - id: to_state
    type:
      - 'null'
      - string
    doc: Label transitions to this state. Can be combined with from.
    inputBinding:
      position: 101
      prefix: --to
  - id: trait
    type:
      - 'null'
      - string
    doc: Trait whose transitions are begin put on tree
    inputBinding:
      position: 101
      prefix: --trait
  - id: transition_name
    type:
      - 'null'
      - string
    doc: The name of the annotation that will hold transitions.
    inputBinding:
      position: 101
      prefix: --transition_name
  - id: transition_prefix
    type:
      - 'null'
      - string
    doc: prefix for each transition value
    inputBinding:
      position: 101
      prefix: --transition_prefix
outputs:
  - id: output
    type: File
    doc: The output file (or directory if --exploded_trees is used)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
