cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - stats
label: gotree_stats
doc: "Print statistics about the tree\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: input_tree
    type:
      - 'null'
      - File
    doc: Input tree
    default: stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Random Seed: -1 = nano seconds since 1970/01/01 00:00:00'
    default: -1
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (Max=20)
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: tree_format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain)
    default: newick
    inputBinding:
      position: 101
      prefix: --format
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
