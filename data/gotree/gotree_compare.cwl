cwlVersion: v1.2
class: CommandLineTool
baseCommand: gotree compare
label: gotree_compare
doc: "Compare full trees, edges, or tips.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: compared_trees_input_file
    type:
      - 'null'
      - string
    doc: Compared trees input file
    inputBinding:
      position: 101
      prefix: --compared
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
  - id: reference_tree_input_file
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
stdout: gotree_compare.out
