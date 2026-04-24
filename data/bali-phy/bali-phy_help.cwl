cwlVersion: v1.2
class: CommandLineTool
baseCommand: bali-phy
label: bali-phy_help
doc: "Bayesian Inference of Alignment and Phylogeny\n\nTool homepage: http://www.bali-phy.org"
inputs:
  - id: sequence_files
    type:
      type: array
      items: File
    doc: Sequence files
    inputBinding:
      position: 1
  - id: alignment_file
    type:
      - 'null'
      - File
    doc: Sequence file & initial alignment
    inputBinding:
      position: 102
      prefix: --align
  - id: alphabet
    type:
      - 'null'
      - string
    doc: The alphabet
    inputBinding:
      position: 102
      prefix: --alphabet
  - id: config_file
    type:
      - 'null'
      - File
    doc: Command file to read
    inputBinding:
      position: 102
      prefix: --config
  - id: fix_parameters
    type:
      - 'null'
      - string
    doc: Fix topology,tree,alignment
    inputBinding:
      position: 102
      prefix: --fix
  - id: indel_rates
    type:
      - 'null'
      - string
    doc: 'Indel rates: constant, *relaxed, or an expression'
    inputBinding:
      position: 102
      prefix: --indel-rates
  - id: insertion_deletion_model
    type:
      - 'null'
      - string
    doc: Insertion-deletion model
    inputBinding:
      position: 102
      prefix: --imodel
  - id: iterations
    type:
      - 'null'
      - int
    doc: The number of iterations to run
    inputBinding:
      position: 102
      prefix: --iterations
  - id: link_partitions
    type:
      - 'null'
      - string
    doc: Link partitions
    inputBinding:
      position: 102
      prefix: --link
  - id: output_directory_name
    type:
      - 'null'
      - string
    doc: Name for the output directory to create
    inputBinding:
      position: 102
      prefix: --name
  - id: scale_prior
    type:
      - 'null'
      - string
    doc: Prior on the scale
    inputBinding:
      position: 102
      prefix: --scale
  - id: subst_rates
    type:
      - 'null'
      - string
    doc: 'Subst rates: *constant, relaxed, or an expression'
    inputBinding:
      position: 102
      prefix: --subst-rates
  - id: substitution_model
    type:
      - 'null'
      - string
    doc: Substitution model
    inputBinding:
      position: 102
      prefix: --smodel
  - id: test
    type:
      - 'null'
      - boolean
    doc: Analyze the initial values and exit
    inputBinding:
      position: 102
      prefix: --test
  - id: tree_prior
    type:
      - 'null'
      - string
    doc: 'Tree prior: ~uniform_tree(taxa), ~uniform_rooted_tree(taxa), ~yule(taxa),
      etc.'
    inputBinding:
      position: 102
      prefix: --tree
  - id: variable_definitions
    type:
      - 'null'
      - string
    doc: Variable definitions
    inputBinding:
      position: 102
      prefix: --variables
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bali-phy:4.1--py314hedd121d_0
stdout: bali-phy_help.out
