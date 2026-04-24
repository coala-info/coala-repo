cwlVersion: v1.2
class: CommandLineTool
baseCommand: gotree graft
label: gotree_graft
doc: "Graft a tree t2 on a tree t1, at the position of a given tip.\nThe root of t2
  will replace the given tip of t2.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: graft_tree
    type:
      - 'null'
      - string
    doc: Tree to graft
    inputBinding:
      position: 101
      prefix: --graft
  - id: input_tree_format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain)
    inputBinding:
      position: 101
      prefix: --format
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Random Seed: -1 = nano seconds since 1970/01/01 00:00:00'
    inputBinding:
      position: 101
      prefix: --seed
  - id: reference_tree
    type:
      - 'null'
      - string
    doc: Reference tree input file
    inputBinding:
      position: 101
      prefix: --reftree
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (Max=20)
    inputBinding:
      position: 101
      prefix: --threads
  - id: tip_name
    type:
      - 'null'
      - string
    doc: Name of the tip to graft the second tree at
    inputBinding:
      position: 101
      prefix: --tip
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output tree
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
