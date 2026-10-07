cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coconet
  - run
label: coconet-binning_run
doc: "Run complete workflow (recommended): preprocess, learn and cluster\n\nTool homepage: https://github.com/Puumanamana/CoCoNet"
inputs:
  - id: output
    type: string
    doc: "Path to output directory (default: output)"
    inputBinding:
      position: 101
      prefix: --output
  - id: fasta
    type: File
    doc: "Path to your assembly file (fasta formatted)"
    inputBinding:
      position: 101
      prefix: --fasta
  - id: h5
    type:
      - 'null'
      - File
    doc: "Experimental: coverage in hdf5 format (keys are contigs, values are (sample, contig_len) ndarrays"
    inputBinding:
      position: 101
      prefix: --h5
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (default: 5)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Print debugging statements"
    inputBinding:
      position: 101
      prefix: --debug
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Less verbose"
    inputBinding:
      position: 101
      prefix: --quiet
  - id: silent
    type:
      - 'null'
      - boolean
    doc: "Only error messages"
    inputBinding:
      position: 101
      prefix: --silent
  - id: continue_run
    type:
      - 'null'
      - boolean
    doc: "Start from last checkpoint. The output directory needs to be the same."
    inputBinding:
      position: 101
      prefix: --continue
  - id: bam
    type:
      - 'null'
      - type: array
        items: File
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
    doc: "List of paths to your coverage files (bam formatted)"
    inputBinding:
      position: 101
      prefix: --bam
  - id: min_ctg_len
    type:
      - 'null'
      - int
    doc: "Minimum contig length (default: 2048)"
    inputBinding:
      position: 101
      prefix: --min-ctg-len
  - id: min_prevalence
    type:
      - 'null'
      - int
    doc: "Minimum contig prevalence for binning. Contig with less that value are filtered out. (default: 2)"
    inputBinding:
      position: 101
      prefix: --min-prevalence
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: "Minimum alignment quality (default: 30)"
    inputBinding:
      position: 101
      prefix: --min-mapping-quality
  - id: min_aln_coverage
    type:
      - 'null'
      - int
    doc: "Discard alignments with less than 50% aligned nucleotides"
    inputBinding:
      position: 101
      prefix: --min-aln-coverage
  - id: flag
    type:
      - 'null'
      - int
    doc: "SAM flag for filtering (same as samtools \"-F\" option) (default: 3596)"
    inputBinding:
      position: 101
      prefix: --flag
  - id: tlen_range
    type:
      - 'null'
      - type: array
        items: int
    doc: "Only allow for paired alignments with spacing within this range (two values)"
    inputBinding:
      position: 101
      prefix: --tlen-range
  - id: min_dtr_size
    type:
      - 'null'
      - int
    doc: "Minimum size of DTR to flag complete contigs (default: 10)"
    inputBinding:
      position: 101
      prefix: --min-dtr-size
  - id: fragment_step
    type:
      - 'null'
      - int
    doc: "Fragments spacing (default: 128)"
    inputBinding:
      position: 101
      prefix: --fragment-step
  - id: test_ratio
    type:
      - 'null'
      - float
    doc: "Ratio for train / test split (default: 0.1)"
    inputBinding:
      position: 101
      prefix: --test-ratio
  - id: n_train
    type:
      - 'null'
      - int
    doc: "Maximum number of training examples (default: 4000000)"
    inputBinding:
      position: 101
      prefix: --n-train
  - id: n_test
    type:
      - 'null'
      - int
    doc: "Number of test examples (default: 10000)"
    inputBinding:
      position: 101
      prefix: --n-test
  - id: learning_rate
    type:
      - 'null'
      - float
    doc: "Learning rate for gradient descent (default: 0.001)"
    inputBinding:
      position: 101
      prefix: --learning-rate
  - id: batch_size
    type:
      - 'null'
      - int
    doc: "Batch size for training (default: 256)"
    inputBinding:
      position: 101
      prefix: --batch-size
  - id: test_batch
    type:
      - 'null'
      - int
    doc: "Run test every 400 batches"
    inputBinding:
      position: 101
      prefix: --test-batch
  - id: patience
    type:
      - 'null'
      - int
    doc: "Early stopping if test accuracy does not improve for 5 consecutive tests"
    inputBinding:
      position: 101
      prefix: --patience
  - id: load_batch
    type:
      - 'null'
      - int
    doc: "Number of coverage batch to load in memory. Consider lowering this value if your RAM is limited. (default: 100)"
    inputBinding:
      position: 101
      prefix: --load-batch
  - id: compo_neurons
    type:
      - 'null'
      - type: array
        items: int
    doc: "Number of neurons for the composition dense layers (x2) (default: 64 32)"
    inputBinding:
      position: 101
      prefix: --compo-neurons
  - id: cover_neurons
    type:
      - 'null'
      - type: array
        items: int
    doc: "Number of neurons for the coverage dense layers (x2) (default: 64 32)"
    inputBinding:
      position: 101
      prefix: --cover-neurons
  - id: cover_filters
    type:
      - 'null'
      - int
    doc: "Number of filters for convolution layer of coverage network. (default: 16)"
    inputBinding:
      position: 101
      prefix: --cover-filters
  - id: cover_kernel
    type:
      - 'null'
      - int
    doc: "Kernel size for convolution layer of coverage network. (default: 4)"
    inputBinding:
      position: 101
      prefix: --cover-kernel
  - id: cover_stride
    type:
      - 'null'
      - int
    doc: "Convolution stride for convolution layer of coverage network. (default: 2)"
    inputBinding:
      position: 101
      prefix: --cover-stride
  - id: merge_neurons
    type:
      - 'null'
      - int
    doc: "Number of neurons for the merging layer (x1) (default: 32)"
    inputBinding:
      position: 101
      prefix: --merge-neurons
  - id: kmer
    type:
      - 'null'
      - int
    doc: "k-mer size for composition vector (default: 4)"
    inputBinding:
      position: 101
      prefix: --kmer
  - id: no_rc
    type:
      - 'null'
      - boolean
    doc: "Do not add the reverse complement k-mer occurrences to the composition vector."
    inputBinding:
      position: 101
      prefix: --no-rc
  - id: wsize
    type:
      - 'null'
      - int
    doc: "Smoothing window size for coverage vector (default: 64)"
    inputBinding:
      position: 101
      prefix: --wsize
  - id: wstep
    type:
      - 'null'
      - int
    doc: "Subsampling step for coverage vector (default: 32)"
    inputBinding:
      position: 101
      prefix: --wstep
  - id: n_frags
    type:
      - 'null'
      - int
    doc: "Number of fragments to split the contigs for the clustering phase (default: 30)"
    inputBinding:
      position: 101
      prefix: --n-frags
  - id: max_neighbors
    type:
      - 'null'
      - int
    doc: "Maximum number of neighbors to consider to compute the adjacency matrix. (default: 250)"
    inputBinding:
      position: 101
      prefix: --max-neighbors
  - id: vote_threshold
    type:
      - 'null'
      - float
    doc: "When this parameter is not set, contig-contig edges are computed by summing the probability between all pairwise fragments between them. Otherwise, adopt a voting strategy and sets a hard-threshold on the probability from each pairwise comparison."
    inputBinding:
      position: 101
      prefix: --vote-threshold
  - id: algorithm
    type:
      - 'null'
      - string
    doc: "Algorithm for clustering the contig-contig graph (leiden or spectral). The number of clusters is required if \"spectral\" is chosen. (default: leiden)"
    inputBinding:
      position: 101
      prefix: --algorithm
  - id: theta
    type:
      - 'null'
      - float
    doc: "(leiden) Minimum percent of edges between two contigs to form an edge between them (default: 0.8)"
    inputBinding:
      position: 101
      prefix: --theta
  - id: gamma1
    type:
      - 'null'
      - float
    doc: "(leiden) CPM optimization value for the first run of the Leiden clustering (default: 0.3)"
    inputBinding:
      position: 101
      prefix: --gamma1
  - id: gamma2
    type:
      - 'null'
      - float
    doc: "(leiden) CPM optimization value for the second run of the Leiden clustering (default: 0.4)"
    inputBinding:
      position: 101
      prefix: --gamma2
  - id: n_clusters
    type:
      - 'null'
      - int
    doc: "(spectral clustering) Maximum number of clusters"
    inputBinding:
      position: 101
      prefix: --n-clusters
  - id: recruit_small_contigs
    type:
      - 'null'
      - boolean
    doc: "Salvage short contigs (<2048)"
    inputBinding:
      position: 101
      prefix: --recruit-small-contigs
  - id: fragment_length
    type:
      - 'null'
      - int
    doc: "Length of contig fragments in bp. Default is half the minimum contig length. (default: -1)"
    inputBinding:
      position: 101
      prefix: --fragment-length
  - id: features
    type:
      - 'null'
      - type: array
        items: string
    doc: "Features for binning (composition, coverage, or both) (default: coverage composition)"
    inputBinding:
      position: 101
      prefix: --features
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coconet-binning:1.1.0--py_0
