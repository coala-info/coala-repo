cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - augur
  - clades
label: augur_clades
doc: "Assign clades to nodes in a tree based on amino-acid or nucleotide signatures.
  Nodes which are members of a clade are stored via <OUTPUT_NODE_DATA> → nodes → <node_name>
  → clade_membership and if this file is used in `augur export v2` these will automatically
  become a coloring. The basal nodes of each clade are also given a branch label which
  is stored via <OUTPUT_NODE_DATA> → branches → <node_name> → labels → clade. The
  keys \"clade_membership\" and \"clade\" are customisable via command line arguments.\n\
  \nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: clades
    type: File
    doc: TSV file containing clade definitions by amino-acid
    default: None
    inputBinding:
      position: 101
      prefix: --clades
  - id: label_name
    type:
      - 'null'
      - string
    doc: Key to store clade labels under; use "None" to not export this
    default: clade
    inputBinding:
      position: 101
      prefix: --label-name
  - id: membership_name
    type:
      - 'null'
      - string
    doc: Key to store clade membership under; use "None" to not export this
    default: clade_membership
    inputBinding:
      position: 101
      prefix: --membership-name
  - id: mutations
    type:
      type: array
      items: File
    doc: JSON(s) containing ancestral and tip nucleotide and/or amino-acid 
      mutations
    default: None
    inputBinding:
      position: 101
      prefix: --mutations
  - id: skip_validation
    type:
      - 'null'
      - boolean
    doc: Skip validation of input/output files, equivalent to 
      --validation-mode=skip. Use at your own risk!
    default: None
    inputBinding:
      position: 101
      prefix: --skip-validation
  - id: tree
    type: File
    doc: prebuilt Newick -- no tree will be built if provided
    default: None
    inputBinding:
      position: 101
      prefix: --tree
  - id: validation_mode
    type:
      - 'null'
      - string
    doc: Control if optional validation checks are performed and what happens if
      they fail. 'error' and 'warn' modes perform validation and emit messages 
      about failed validation checks. 'error' mode causes a non- zero exit 
      status if any validation checks failed, while 'warn' does not. 'skip' mode
      performs no validation. Note that some validation checks are non- optional
      and as such are not affected by this setting.
    default: error
    inputBinding:
      position: 101
      prefix: --validation-mode
outputs:
  - id: output_node_data
    type:
      - 'null'
      - File
    doc: name of JSON file to save clade assignments to
    outputBinding:
      glob: $(inputs.output_node_data)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
