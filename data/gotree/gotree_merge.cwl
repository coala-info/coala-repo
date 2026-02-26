cwlVersion: v1.2
class: CommandLineTool
baseCommand: gotree_merge
label: gotree_merge
doc: "Merges two rooted trees by adding a new root connecting two former roots.\n\n\
  Tool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: compared_tree
    type:
      - 'null'
      - string
    doc: Compared tree input file
    default: stdin
    inputBinding:
      position: 101
      prefix: --compared
  - id: input_tree_format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain)
    default: newick
    inputBinding:
      position: 101
      prefix: --format
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Random Seed: -1 = nano seconds since 1970/01/01 00:00:00'
    default: -1
    inputBinding:
      position: 101
      prefix: --seed
  - id: reference_tree
    type:
      - 'null'
      - string
    doc: Reference tree input file
    default: stdin
    inputBinding:
      position: 101
      prefix: --reftree
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads (Max=20)
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Merged tree output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
