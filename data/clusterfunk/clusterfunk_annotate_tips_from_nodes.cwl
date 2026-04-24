cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clusterfunk
  - annotate_tips_from_nodes
label: clusterfunk_annotate_tips_from_nodes
doc: "Annotate tips of a tree from its nodes based on specified traits.\n\nTool homepage:
  https://github.com/cov-ert/clusterfunk"
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
  - id: format
    type:
      - 'null'
      - string
    doc: what format is the tree file. This is passed to dendropy. default is 
      'nexus'
    inputBinding:
      position: 101
      prefix: --format
  - id: input_tree
    type: File
    doc: The input tree file. Format can be specified with the format flag.
    inputBinding:
      position: 101
      prefix: --input
  - id: stop_where_trait
    type:
      - 'null'
      - string
    doc: 'optional filter for when to stop pushing annotation forward in preorder
      traversal from mrca. Format: <trait>=<regex>'
    inputBinding:
      position: 101
      prefix: --stop-where-trait
  - id: traits
    type:
      - 'null'
      - type: array
        items: string
    doc: Space separated list of discrete traits to annotate on tree
    inputBinding:
      position: 101
      prefix: --traits
outputs:
  - id: output_tree
    type: File
    doc: The output file
    outputBinding:
      glob: $(inputs.output_tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0
