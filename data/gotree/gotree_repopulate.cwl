cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - repopulate
label: gotree_repopulate
doc: "Re populate the tree with tips that have the same sequences.\n\nTool homepage:
  https://github.com/fredericlemoine/gotree"
inputs:
  - id: input_tree_file
    type: File
    doc: A input tree
    inputBinding:
      position: 1
  - id: identical_tips_file
    type: File
    doc: A file containing a list of tips that are identical
    inputBinding:
      position: 2
  - id: id_groups
    type:
      - 'null'
      - string
    doc: File with groups of identical tips
    inputBinding:
      position: 103
      prefix: --id-groups
  - id: input_tree
    type:
      - 'null'
      - File
    doc: Input tree
    inputBinding:
      position: 103
      prefix: --input
  - id: input_tree_format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain)
    inputBinding:
      position: 103
      prefix: --format
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Random Seed: -1 = nano seconds since 1970/01/01 00:00:00'
    inputBinding:
      position: 103
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (Max=20)
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Renamed tree output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
