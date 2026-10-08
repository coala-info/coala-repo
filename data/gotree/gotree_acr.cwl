cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - acr
label: gotree_acr
doc: "Reconstructs most parsimonious ancestral characters.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: algo
    type:
      - 'null'
      - string
    doc: "Parsimony algorithm for resolving ambiguities: acctran, deltran, or downpass"
    inputBinding:
      position: 101
      prefix: --algo
  - id: input_tree
    type: File
    doc: "Input tree"
    inputBinding:
      position: 101
      prefix: --input
  - id: out_states_path
    type:
      - 'null'
      - string
    doc: "Output mapping file between node names and states"
    inputBinding:
      position: 101
      prefix: --out-states
  - id: out_steps_path
    type:
      - 'null'
      - string
    doc: "Output file with number of parsimony steps"
    inputBinding:
      position: 101
      prefix: --out-steps
  - id: output_file_path
    type: string
    doc: "Output file"
    inputBinding:
      position: 101
      prefix: --output
  - id: random_resolve
    type:
      - 'null'
      - boolean
    doc: "Random resolve states when several possibilities in: acctran, deltran, or downpass"
    inputBinding:
      position: 101
      prefix: --random-resolve
  - id: states_file
    type: File
    doc: "Tip state file (One line per tip, tab separated: tipname\\tstate)"
    inputBinding:
      position: 101
      prefix: --states
  - id: tree_format
    type:
      - 'null'
      - string
    doc: "Input tree format (newick, nexus, phyloxml, or nextstrain)"
    inputBinding:
      position: 101
      prefix: --format
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random Seed: -1 = nano seconds since 1970/01/01 00:00:00"
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (Max=20)"
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out_states_file
    type:
      - 'null'
      - File
    doc: "Output mapping file between node names and states"
    outputBinding:
      glob: "$(inputs.out_states_path)"
  - id: out_steps_file
    type:
      - 'null'
      - File
    doc: "Output file with number of parsimony steps"
    outputBinding:
      glob: "$(inputs.out_steps_path)"
  - id: output_file
    type: File
    doc: "Output file written to the path in output_file_path"
    outputBinding:
      glob: "$(inputs.output_file_path)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
