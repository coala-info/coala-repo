cwlVersion: v1.2
class: CommandLineTool
baseCommand: ClonalFrameML
label: clonalframeml
doc: "Efficient inference of recombination in whole bacterial genomes using a maximum-likelihood
  approach.\n\nTool homepage: https://github.com/xavierdidelot/ClonalFrameML"
inputs:
  - id: tree_file
    type: File
    doc: Input Newick tree file
    inputBinding:
      position: 1
  - id: alignment_file
    type: File
    doc: Input alignment file (FASTA or PHYLIP format)
    inputBinding:
      position: 2
  - id: bootstrap_replicates
    type:
      - 'null'
      - int
    doc: Number of bootstrap replicates
    inputBinding:
      position: 103
      prefix: -b
  - id: delta
    type:
      - 'null'
      - float
    doc: The average length of recombination events
    inputBinding:
      position: 103
      prefix: -delta
  - id: ems
    type:
      - 'null'
      - boolean
    doc: Whether or not to use the Expectation-Maximization algorithm to estimate
      parameters
    default: false
    inputBinding:
      position: 103
      prefix: -ems
  - id: ignore_user_parameters
    type:
      - 'null'
      - boolean
    doc: Ignore user-provided parameters even if they are specified
    default: false
    inputBinding:
      position: 103
      prefix: -ignore_user_parameters
  - id: kappa
    type:
      - 'null'
      - float
    doc: Relative rate of transitions vs transversions
    inputBinding:
      position: 103
      prefix: -kappa
  - id: lambda
    type:
      - 'null'
      - float
    doc: The divergence of imported DNA
    inputBinding:
      position: 103
      prefix: -lambda
  - id: max_recombination_length
    type:
      - 'null'
      - int
    doc: Maximum length of recombination events
    default: 10000
    inputBinding:
      position: 103
      prefix: -max_recombination_length
  - id: min_recombination_length
    type:
      - 'null'
      - int
    doc: Minimum length of recombination events
    default: 1
    inputBinding:
      position: 103
      prefix: -min_recombination_length
  - id: nu
    type:
      - 'null'
      - float
    doc: The rate of recombination
    inputBinding:
      position: 103
      prefix: -nu
  - id: recombination_likelihood
    type:
      - 'null'
      - boolean
    doc: Whether to output the likelihood of recombination at each site
    default: false
    inputBinding:
      position: 103
      prefix: -recombination_likelihood
  - id: show_progress
    type:
      - 'null'
      - boolean
    doc: Whether to show progress of the algorithm
    default: false
    inputBinding:
      position: 103
      prefix: -show_progress
  - id: tau
    type:
      - 'null'
      - float
    doc: The rate of mutation
    inputBinding:
      position: 103
      prefix: -tau
outputs:
  - id: output_prefix
    type: File
    doc: Prefix for all output files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clonalframeml:1.13--h9948957_2
