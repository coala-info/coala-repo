cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - subtree
label: gotree_subtree
doc: "Select a subtree from the input tree whose root has the given name.\n\nTool
  homepage: https://github.com/fredericlemoine/gotree"
inputs:
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
  - id: node_name
    type:
      - 'null'
      - string
    doc: Name of the node to select as the root of the subtree (maybe a regex)
    inputBinding:
      position: 101
      prefix: --name
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
  - id: output_tree_file
    type:
      - 'null'
      - File
    doc: Output tree file
    outputBinding:
      glob: $(inputs.output_tree_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
