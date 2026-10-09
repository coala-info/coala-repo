cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hyphy
  - molerate
label: hyphy_molerate
doc: "Available analysis command line options\n\nTool homepage: http://hyphy.org/"
inputs:
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of threads to use (HyPhy CPU= argument).
    inputBinding:
      position: 100
      prefix: CPU=
      separate: false
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
      - string
    doc: 'Perform test clade branch-level testing: Yes or No (default: No).'
    inputBinding:
      position: 101
      prefix: --branch-level-analysis
  - id: branches
    type:
      type: array
      items: string
      inputBinding:
        prefix: --branches
    doc: Designated lineages to test; each branch name is passed as its own 
      --branches option.
    inputBinding:
      position: 101
  - id: full_model
    type:
      - 'null'
      - string
    doc: 'Fit the full unconstrained model: Yes or No (default: Yes).'
    inputBinding:
      position: 101
      prefix: --full-model
  - id: labeling_strategy
    type:
      - 'null'
      - string
    doc: Labeling strategy for internal nodes
    inputBinding:
      position: 101
      prefix: --labeling-strategy
  - id: model
    type:
      - 'null'
      - string
    doc: The substitution model to use
    inputBinding:
      position: 101
      prefix: --model
  - id: rate_classes
    type:
      - 'null'
      - int
    doc: How many site rate classes to use
    inputBinding:
      position: 101
      prefix: --rate-classes
  - id: rv
    type:
      - 'null'
      - string
    doc: Site to site rate variation
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
    inputBinding:
      position: 101
      prefix: --type
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write the resulting JSON to this file (default is to save to the same 
      path as the alignment file + 'MG94.json')
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
