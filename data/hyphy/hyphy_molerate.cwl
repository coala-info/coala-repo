cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyphy_molerate
label: hyphy_molerate
doc: "Available analysis command line options\n\nTool homepage: http://hyphy.org/"
inputs:
  - id: alignment
    type: File
    doc: A protein multiple sequence alignment in one of the formats supported 
      by HyPhy (single partition)
    inputBinding:
      position: 101
      prefix: --alignment
  - id: branch_level_analysis
    type:
      - 'null'
      - boolean
    doc: Perform test clade branch-level testing
    default: No
    inputBinding:
      position: 101
      prefix: --branch-level-analysis
  - id: branches
    type: string
    doc: Designated lineages to test
    inputBinding:
      position: 101
      prefix: --branches
  - id: full_model
    type:
      - 'null'
      - boolean
    doc: Fit the full unconstrained model
    default: Yes
    inputBinding:
      position: 101
      prefix: --full-model
  - id: labeling_strategy
    type:
      - 'null'
      - string
    doc: Labeling strategy for internal nodes
    default: all-descendants
    inputBinding:
      position: 101
      prefix: --labeling-strategy
  - id: model
    type:
      - 'null'
      - string
    doc: The substitution model to use
    default: WAG
    inputBinding:
      position: 101
      prefix: --model
  - id: rate_classes
    type:
      - 'null'
      - int
    doc: How many site rate classes to use
    default: 4
    inputBinding:
      position: 101
      prefix: --rate-classes
  - id: rv
    type:
      - 'null'
      - string
    doc: Site to site rate variation
    default: None
    inputBinding:
      position: 101
      prefix: --rv
  - id: tree
    type: File
    doc: A phylogenetic tree with branch lengths
    inputBinding:
      position: 101
      prefix: --tree
  - id: type
    type:
      - 'null'
      - string
    doc: The type of data to perform screening on
    default: protein
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write the resulting JSON to this file (default is to save to the same 
      path as the alignment file + 'MG94.json')
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
