cwlVersion: v1.2
class: CommandLineTool
baseCommand: remag
label: remag
doc: "REMAG: Recovery of Eukaryotic Metagenome-Assembled Genomes. A metagenomic binning tool for recovering high-quality eukaryotic genomes from mixed prokaryotic-eukaryotic samples using contrastive learning.\n\nTool homepage: https://github.com/danielzmbp/remag"
inputs:
  - id: fasta
    type: File
    doc: "Input FASTA file containing contigs to bin into genomes. Supports gzipped files."
    inputBinding:
      position: 1
      prefix: --fasta
  - id: coverage
    type:
      - 'null'
      - type: array
        items: File
    doc: "Coverage files for calculation. Supports BAM, CRAM (indexed), and TSV formats. Each file represents one sample. The paths are passed as one space-separated value."
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 1
      prefix: --coverage
      itemSeparator: ' '
  - id: output
    type: string
    doc: "Output directory for binning results and intermediate files."
    inputBinding:
      position: 1
      prefix: --output
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of CPU cores to use for parallel processing. [8]"
    inputBinding:
      position: 1
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable detailed logging output."
    inputBinding:
      position: 1
      prefix: --verbose
  - id: keep_intermediate
    type:
      - 'null'
      - boolean
    doc: "Keep intermediate files (embeddings, features, model, etc.). By default, only bins.csv and bins/ folder are kept."
    inputBinding:
      position: 1
      prefix: --keep-intermediate
  - id: epochs
    type:
      - 'null'
      - int
    doc: "Number of training epochs for contrastive learning model. [400]"
    inputBinding:
      position: 1
      prefix: --epochs
  - id: batch_size
    type:
      - 'null'
      - int
    doc: "Batch size for contrastive learning training. [2048]"
    inputBinding:
      position: 1
      prefix: --batch-size
  - id: embedding_dim
    type:
      - 'null'
      - int
    doc: "Dimensionality of contig embeddings in contrastive learning. [256]"
    inputBinding:
      position: 1
      prefix: --embedding-dim
  - id: base_learning_rate
    type:
      - 'null'
      - float
    doc: "Base learning rate for contrastive learning training (scaled by batch size). [0.005]"
    inputBinding:
      position: 1
      prefix: --base-learning-rate
  - id: max_positive_pairs
    type:
      - 'null'
      - int
    doc: "Maximum number of positive pairs for contrastive learning training. [5000000]"
    inputBinding:
      position: 1
      prefix: --max-positive-pairs
  - id: num_augmentations
    type:
      - 'null'
      - int
    doc: "Number of random fragments per contig for data augmentation. [8]"
    inputBinding:
      position: 1
      prefix: --num-augmentations
  - id: min_cluster_size
    type:
      - 'null'
      - int
    doc: "Minimum number of contigs required to form a cluster/bin. [2]"
    inputBinding:
      position: 1
      prefix: --min-cluster-size
  - id: leiden_resolution
    type:
      - 'null'
      - float
    doc: "Resolution parameter for Leiden clustering (higher = more clusters). If not specified, auto-resolution is used."
    inputBinding:
      position: 1
      prefix: --leiden-resolution
  - id: auto_resolution
    type:
      - 'null'
      - boolean
    doc: "Automatically determine optimal Leiden resolution based on core gene duplications (enabled by default)."
    inputBinding:
      position: 1
      prefix: --auto-resolution
  - id: leiden_k_neighbors
    type:
      - 'null'
      - int
    doc: "Number of nearest neighbors for k-NN graph construction in Leiden clustering. If not set, defaults to 15 (metagenomics) or 25 (single-cell mode)."
    inputBinding:
      position: 1
      prefix: --leiden-k-neighbors
  - id: leiden_similarity_threshold
    type:
      - 'null'
      - float
    doc: "Minimum cosine similarity threshold for k-NN graph edges in Leiden clustering. [0.1]"
    inputBinding:
      position: 1
      prefix: --leiden-similarity-threshold
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: "Minimum contig length in base pairs for binning consideration. [1000]"
    inputBinding:
      position: 1
      prefix: --min-contig-length
  - id: min_bin_size
    type:
      - 'null'
      - int
    doc: "Minimum total bin size in base pairs for output. [500000]"
    inputBinding:
      position: 1
      prefix: --min-bin-size
  - id: coverage_batch_size
    type:
      - 'null'
      - int
    doc: "Number of contigs to process per batch when calculating coverage from alignment files. [100000]"
    inputBinding:
      position: 1
      prefix: --coverage-batch-size
  - id: hyenadna_batch_size
    type:
      - 'null'
      - int
    doc: "Batch size for HyenaDNA model inference. [1024]"
    inputBinding:
      position: 1
      prefix: --hyenadna-batch-size
  - id: skip_bacterial_filter
    type:
      - 'null'
      - boolean
    doc: "Skip eukaryotic contig filtering using HyenaDNA classifier (keeps all contigs)."
    inputBinding:
      position: 1
      prefix: --skip-bacterial-filter
  - id: save_filtered_contigs
    type:
      - 'null'
      - boolean
    doc: "Save non-eukaryotic (filtered out) contigs to a separate FASTA file in the output directory."
    inputBinding:
      position: 1
      prefix: --save-filtered-contigs
  - id: skip_refinement
    type:
      - 'null'
      - boolean
    doc: "Skip post-clustering bin refinement and optimization."
    inputBinding:
      position: 1
      prefix: --skip-refinement
  - id: save_bins_before_refinement
    type:
      - 'null'
      - boolean
    doc: "Save bins (bins.csv and FASTA files) before refinement step, with '_before_refinement' suffix."
    inputBinding:
      position: 1
      prefix: --save-bins-before-refinement
  - id: max_refinement_rounds
    type:
      - 'null'
      - int
    doc: "Maximum number of iterative bin refinement rounds. [2]"
    inputBinding:
      position: 1
      prefix: --max-refinement-rounds
  - id: min_duplications_for_refinement
    type:
      - 'null'
      - int
    doc: "Minimum number of duplicated core genes required to trigger refinement. [1]"
    inputBinding:
      position: 1
      prefix: --min-duplications-for-refinement
  - id: skip_chimera_detection
    type:
      - 'null'
      - boolean
    doc: "Skip chimeric contig detection and splitting for large contigs."
    inputBinding:
      position: 1
      prefix: --skip-chimera-detection
  - id: barlow_lambda
    type:
      - 'null'
      - float
    doc: "Lambda parameter for Barlow Twins loss (redundancy reduction term). Default (auto): 0.003 for single/no coverage, 0.005 for multi-sample/coassembly."
    inputBinding:
      position: 1
      prefix: --barlow-lambda
  - id: mode
    type:
      - 'null'
      - string
    doc: "Preset mode adjusting clustering defaults: metagenomics (default) or single-cell."
    inputBinding:
      position: 1
      prefix: --mode
  - id: random_seed
    type:
      - 'null'
      - int
    doc: "Random seed for reproducible training. [42]"
    inputBinding:
      position: 1
      prefix: --random-seed
  - id: filter_only
    type:
      - 'null'
      - boolean
    doc: "Only run eukaryotic filtering and write filtered FASTA; skip feature generation, training, and binning."
    inputBinding:
      position: 1
      prefix: --filter-only
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
  - id: output_dir
    type: Directory
    doc: "Output directory with bins/ and bins.csv"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/remag:0.3.4--pyhdfd78af_0
stdout: remag.out
