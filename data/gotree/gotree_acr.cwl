cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - acr
label: gotree_acr
doc: "Reconstructs most parsimonious ancestral characters.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: algorithm
    type:
      - 'null'
      - string
    doc: 'Parsimony algorithm for resolving ambiguities: acctran, deltran, or downpass'
    default: acctran
    inputBinding:
      position: 101
      prefix: --algo
  - id: input_tree
    type:
      - 'null'
      - string
    doc: Input tree
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
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output file
    default: stdout
    inputBinding:
      position: 101
      prefix: --output
  - id: output_states
    type:
      - 'null'
      - string
    doc: Output mapping file between node names and states
    default: none
    inputBinding:
      position: 101
      prefix: --out-states
  - id: output_steps
    type:
      - 'null'
      - string
    doc: Output file with number of parsimony steps
    default: stdout
    inputBinding:
      position: 101
      prefix: --out-steps
  - id: random_resolve
    type:
      - 'null'
      - boolean
    doc: 'Random resolve states when several possibilities in: acctran, deltran, or
      downpass'
    inputBinding:
      position: 101
      prefix: --random-resolve
  - id: random_seed
    type:
      - 'null'
      - int
    doc: 'Random Seed: -1 = nano seconds since 1970/01/01 00:00:00'
    default: -1
    inputBinding:
      position: 101
      prefix: --seed
  - id: states_file
    type:
      - 'null'
      - string
    doc: 'Tip state file (One line per tip, tab separated: tipname\ttstate)'
    default: stdin
    inputBinding:
      position: 101
      prefix: --states
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
stdout: gotree_acr.out
