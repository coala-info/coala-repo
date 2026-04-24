cwlVersion: v1.2
class: CommandLineTool
baseCommand: acdc
label: acdc
doc: "Automated contamination detection and confidence estimation for single-cell
  genome data\n\nTool homepage: https://github.com/mlux86/acdc"
inputs:
  - id: aggressive_threshold
    type:
      - 'null'
      - int
    doc: 'Aggressive threshold: Treat clusters having a bp size below this threshold
      as outliers. (Default = 0 = aggressive mode disabled)'
    inputBinding:
      position: 101
      prefix: --aggressive-threshold
  - id: bootstrap_ratio
    type:
      - 'null'
      - float
    doc: Bootstrap subsampling ratio
    inputBinding:
      position: 101
      prefix: --bootstrap-ratio
  - id: input_fasta
    type:
      - 'null'
      - File
    doc: Input FASTA file
    inputBinding:
      position: 101
      prefix: --input-fasta
  - id: input_list
    type:
      - 'null'
      - File
    doc: File with a list of input FASTA files, one per line
    inputBinding:
      position: 101
      prefix: --input-list
  - id: kraken_db
    type:
      - 'null'
      - Directory
    doc: Database to use for Kraken classification
    inputBinding:
      position: 101
      prefix: --kraken-db
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: Minimal length of contigs to consider for analysis
    inputBinding:
      position: 101
      prefix: --min-contig-length
  - id: num_bootstraps
    type:
      - 'null'
      - int
    doc: Number of bootstraps
    inputBinding:
      position: 101
      prefix: --num-bootstraps
  - id: num_threads
    type:
      - 'null'
      - int
    doc: 'Number of threads for bootstrap analysis (default: detect number of cores)'
    inputBinding:
      position: 101
      prefix: --num-threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Random seed number for reproducible results
    inputBinding:
      position: 101
      prefix: --random-seed
  - id: target_num_points
    type:
      - 'null'
      - int
    doc: Approximate number of target points for estimating window parameters
    inputBinding:
      position: 101
      prefix: --target-num-points
  - id: target_taxonomy
    type:
      - 'null'
      - string
    doc: Target taxonomy identifier, supports regular expressions
    inputBinding:
      position: 101
      prefix: --target-taxonomy
  - id: taxonomy_file
    type:
      - 'null'
      - File
    doc: File with external taxonomy information
    inputBinding:
      position: 101
      prefix: --taxonomy-file
  - id: tsne_dimension
    type:
      - 'null'
      - int
    doc: T-SNE dimension
    inputBinding:
      position: 101
      prefix: --tsne-dimension
  - id: tsne_pca_dimension
    type:
      - 'null'
      - int
    doc: T-SNE initial PCA dimension
    inputBinding:
      position: 101
      prefix: --tsne-pca-dimension
  - id: tsne_perplexity
    type:
      - 'null'
      - float
    doc: T-SNE perplexity (overrides automatic estimation)
    inputBinding:
      position: 101
      prefix: --tsne-perplexity
  - id: tsne_theta
    type:
      - 'null'
      - float
    doc: T-SNE parameter 'theta' of the underlying Barnes-Hut approximation
    inputBinding:
      position: 101
      prefix: --tsne-theta
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output (use -vv for more or -vvv for maximum verbosity)
    inputBinding:
      position: 101
      prefix: --verbose
  - id: window_kmer_length
    type:
      - 'null'
      - int
    doc: Length of the k-mers in the sequence vectorizer window
    inputBinding:
      position: 101
      prefix: --window-kmer-length
  - id: window_step
    type:
      - 'null'
      - int
    doc: Step of the sliding sequence vectorizer window (overrides automatic 
      estimation using number of target points)
    inputBinding:
      position: 101
      prefix: --window-step
  - id: window_width
    type:
      - 'null'
      - int
    doc: Width of the sliding sequence vectorizer window (overrides automatic 
      estimation using number of target points)
    inputBinding:
      position: 101
      prefix: --window-width
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Result output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/acdc:1.02--h4ac6f70_0
