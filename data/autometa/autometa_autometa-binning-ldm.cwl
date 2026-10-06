cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-binning-ldm
label: autometa_autometa-binning-ldm
doc: "Autometa Large-data-mode binning by contig set selection using max-partition-size\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: kmers
    type: File
    doc: "Path to k-mer counts table"
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
  - id: taxonomy
    type: File
    doc: "Path to Autometa assigned taxonomies table"
    inputBinding:
      position: 1
      prefix: --taxonomy
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
  - id: norm_method
    type:
      - 'null'
      - string
    doc: "kmer normalization method (am_clr, ilr, clr) (default: am_clr)"
    inputBinding:
      position: 1
      prefix: --norm-method
  - id: pca_dims
    type:
      - 'null'
      - int
    doc: "PCA dimensions to reduce normalized kmer frequencies prior to embedding (default: 50)"
    inputBinding:
      position: 1
      prefix: --pca-dims
  - id: embed_method
    type:
      - 'null'
      - string
    doc: "kmer embedding method (bhsne, umap, sksne, trimap) (default: bhsne)"
    inputBinding:
      position: 1
      prefix: --embed-method
  - id: embed_dims
    type:
      - 'null'
      - int
    doc: "Embedding dimensions after PCA (default: 2)"
    inputBinding:
      position: 1
      prefix: --embed-dims
  - id: max_partition_size
    type:
      - 'null'
      - int
    doc: "Maximum number of contigs to consider for a recursive binning batch (default: 10000)"
    inputBinding:
      position: 1
      prefix: --max-partition-size
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
  - id: cache
    type:
      - 'null'
      - string
    doc: "Directory to store intermediate checkpoint files during binning"
    inputBinding:
      position: 1
      prefix: --cache
  - id: binning_checkpoints
    type:
      - 'null'
      - string
    doc: "File path to store intermediate contig binning results (requires --cache)"
    inputBinding:
      position: 1
      prefix: --binning-checkpoints
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
  - id: cache_out
    type: Directory?
    doc: "Binning checkpoint cache directory"
    outputBinding:
      glob: "${ return inputs.cache ? inputs.cache : []; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
