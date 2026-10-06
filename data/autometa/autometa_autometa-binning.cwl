cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-binning
label: autometa_autometa-binning
doc: "Perform marker gene guided binning of metagenome contigs using annotations (when available) of sequence composition, coverage and homology.\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: kmers
    type: File
    doc: "Path to embedded k-mers table"
    inputBinding:
      position: 1
      prefix: --kmers
  - id: coverages
    type: File
    doc: "Path to metagenome coverages table"
    inputBinding:
      position: 1
      prefix: --coverages
  - id: gc_content
    type: File
    doc: "Path to metagenome GC contents table"
    inputBinding:
      position: 1
      prefix: --gc-content
  - id: markers
    type: File
    doc: "Path to Autometa annotated markers table"
    inputBinding:
      position: 1
      prefix: --markers
  - id: output_binning
    type: string
    doc: "Path to write Autometa binning results"
    inputBinding:
      position: 1
      prefix: --output-binning
  - id: output_main
    type:
      - 'null'
      - string
    doc: "Path to write Autometa main table used during/after binning"
    inputBinding:
      position: 1
      prefix: --output-main
  - id: clustering_method
    type:
      - 'null'
      - string
    doc: "Clustering algorithm to use for recursive binning (dbscan, hdbscan) (default: dbscan)"
    inputBinding:
      position: 1
      prefix: --clustering-method
  - id: completeness
    type:
      - 'null'
      - float
    doc: "completeness cutoff (0-100) to retain cluster (default: 20.0)"
    inputBinding:
      position: 1
      prefix: --completeness
  - id: purity
    type:
      - 'null'
      - float
    doc: "purity cutoff (0-100) to retain cluster (default: 95.0)"
    inputBinding:
      position: 1
      prefix: --purity
  - id: cov_stddev_limit
    type:
      - 'null'
      - float
    doc: "coverage standard deviation limit to retain cluster (default: 25.0)"
    inputBinding:
      position: 1
      prefix: --cov-stddev-limit
  - id: gc_stddev_limit
    type:
      - 'null'
      - float
    doc: "GC content standard deviation limit to retain cluster (default: 5.0)"
    inputBinding:
      position: 1
      prefix: --gc-stddev-limit
  - id: taxonomy
    type:
      - 'null'
      - File
    doc: "Path to Autometa assigned taxonomies table"
    inputBinding:
      position: 1
      prefix: --taxonomy
  - id: starting_rank
    type:
      - 'null'
      - string
    doc: "Canonical rank at which to begin subsetting taxonomy (superkingdom, phylum, class, order, family, genus, species) (default: superkingdom)"
    inputBinding:
      position: 1
      prefix: --starting-rank
  - id: reverse_ranks
    type:
      - 'null'
      - boolean
    doc: "Reverse order at which to split taxonomy by canonical-rank"
    inputBinding:
      position: 1
      prefix: --reverse-ranks
  - id: rank_filter
    type:
      - 'null'
      - string
    doc: "Taxonomy column canonical rank to subset by the value of --rank-name-filter (superkingdom, phylum, class, order, family, genus, species) (default: superkingdom)"
    inputBinding:
      position: 1
      prefix: --rank-filter
  - id: rank_name_filter
    type:
      - 'null'
      - string
    doc: "Only retrieve contigs with this name in the --rank-filter column (default: bacteria)"
    inputBinding:
      position: 1
      prefix: --rank-name-filter
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "log debug information"
    inputBinding:
      position: 1
      prefix: --verbose
  - id: cpus
    type:
      - 'null'
      - int
    doc: "Number of cores to use by clustering method (default: -1, all available)"
    inputBinding:
      position: 1
      prefix: --cpus
outputs:
  - id: binning_out
    type: File
    doc: "Autometa binning results"
    outputBinding:
      glob: "$(inputs.output_binning)"
  - id: main_out
    type: File?
    doc: "Autometa main table"
    outputBinding:
      glob: "${ return inputs.output_main ? inputs.output_main : []; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
