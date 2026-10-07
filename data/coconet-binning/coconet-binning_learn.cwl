cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coconet
  - learn
label: coconet-binning_learn
doc: "Train neural network on input data\n\nTool homepage: https://github.com/Puumanamana/CoCoNet"
inputs:
  - id: run_dir
    type: Directory
    doc: "Output directory of an earlier coconet step (it is updated in place)"
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
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.run_dir.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.run_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coconet-binning:1.1.0--py_0
