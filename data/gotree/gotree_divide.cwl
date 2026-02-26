cwlVersion: v1.2
class: CommandLineTool
baseCommand: gotree_divide
label: gotree_divide
doc: "Divide an input tree file into several tree files\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input tree(s) file
    default: stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: input_tree_format
    type:
      - 'null'
      - string
    doc: Input tree format (newick, nexus, phyloxml, or nextstrain)
    default: newick
    inputBinding:
      position: 101
      prefix: --format
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Divided trees output file prefix
    default: prefix
    inputBinding:
      position: 101
      prefix: --output
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
stdout: gotree_divide.out
