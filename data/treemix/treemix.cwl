cwlVersion: v1.2
class: CommandLineTool
baseCommand: treemix
label: treemix
doc: "TreeMix is a method for inferring the patterns of population splitting and mixing
  from genome-wide allele frequency data.\n\nTool homepage: http://pritchardlab.stanford.edu/software.html"
inputs:
  - id: input_file
    type: File
    doc: Input file (gzip-compressed allele counts, one population per column)
    inputBinding:
      position: 1
      prefix: -i
  - id: output_stem
    type: string
    doc: Output stem (writes [stem].treeout.gz, [stem].cov.gz, [stem].modelcov.gz)
    inputBinding:
      position: 2
      prefix: -o
  - id: block_size
    type:
      - 'null'
      - int
    doc: Number of SNPs per block for estimation of covariance matrix (default 1)
    inputBinding:
      position: 3
      prefix: -k
  - id: global_optimization
    type:
      - 'null'
      - boolean
    doc: Do a round of global rearrangements after adding all populations
    inputBinding:
      position: 3
      prefix: -global
  - id: tree_file
    type:
      - 'null'
      - File
    doc: Read the tree topology from a file, rather than estimating it
    inputBinding:
      position: 3
      prefix: -tf
  - id: migration_edges
    type:
      - 'null'
      - int
    doc: Number of migration edges to add (default 0)
    inputBinding:
      position: 3
      prefix: -m
  - id: root_population
    type:
      - 'null'
      - string
    doc: Comma-delimited list of populations to set on one side of the root (for
      migration)
    inputBinding:
      position: 3
      prefix: -root
  - id: input_graph
    type:
      - 'null'
      - type: array
        items: File
    doc: Read the graph from a previous TreeMix run - vertices file followed by
      edges file
    inputBinding:
      position: 3
      prefix: -g
  - id: standard_errors
    type:
      - 'null'
      - boolean
    doc: Calculate standard errors of migration weights (computationally expensive)
    inputBinding:
      position: 3
      prefix: -se
  - id: microsatellite
    type:
      - 'null'
      - boolean
    doc: Microsatellite data
    inputBinding:
      position: 3
      prefix: -micro
  - id: bootstrap
    type:
      - 'null'
      - boolean
    doc: Perform a single bootstrap replicate
    inputBinding:
      position: 3
      prefix: -bootstrap
  - id: known_migration
    type:
      - 'null'
      - File
    doc: List of known migration events to include
    inputBinding:
      position: 3
      prefix: -cor_mig
  - id: no_sample_size_correction
    type:
      - 'null'
      - boolean
    doc: Turn off sample size correction
    inputBinding:
      position: 3
      prefix: -noss
  - id: seed
    type:
      - 'null'
      - int
    doc: Set the seed for random number generation
    inputBinding:
      position: 3
      prefix: -seed
  - id: n_warn
    type:
      - 'null'
      - int
    doc: Display first N warnings
    inputBinding:
      position: 3
      prefix: -n_warn
outputs:
  - id: treeout
    type:
      - 'null'
      - File
    doc: Tree and migration edges
    outputBinding:
      glob: $(inputs.output_stem).treeout.gz
  - id: cov
    type:
      - 'null'
      - File
    doc: Observed covariance matrix
    outputBinding:
      glob: $(inputs.output_stem).cov.gz
  - id: modelcov
    type:
      - 'null'
      - File
    doc: Fitted covariance matrix
    outputBinding:
      glob: $(inputs.output_stem).modelcov.gz
  - id: covse
    type:
      - 'null'
      - File
    doc: Standard errors of the covariance matrix
    outputBinding:
      glob: $(inputs.output_stem).covse.gz
  - id: edges
    type:
      - 'null'
      - File
    doc: Graph edges file
    outputBinding:
      glob: $(inputs.output_stem).edges.gz
  - id: vertices
    type:
      - 'null'
      - File
    doc: Graph vertices file
    outputBinding:
      glob: $(inputs.output_stem).vertices.gz
  - id: llik
    type:
      - 'null'
      - File
    doc: Log likelihood file
    outputBinding:
      glob: $(inputs.output_stem).llik
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treemix:1.13--h63c0f18_10
