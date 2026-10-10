cwlVersion: v1.2
class: CommandLineTool
baseCommand: mSWEEP
label: msweep
doc: "mSWEEP estimates the abundances of bacterial lineages (groups of reference sequences) in a sample from Themisto pseudoalignments of its reads.\n\nTool homepage: https://github.com/PROBIC/mSWEEP"
inputs:
  - id: themisto_1
    type: ['null', File]
    doc: "Pseudoalignment results from Themisto for the 1st strand of paired-end reads."
    inputBinding:
      prefix: "--themisto-1"
  - id: themisto_2
    type: ['null', File]
    doc: "Pseudoalignment results from Themisto for the 2nd strand of paired-end reads."
    inputBinding:
      prefix: "--themisto-2"
  - id: themisto
    type:
      - 'null'
      - type: array
        items: File
    doc: "Single Themisto alignment file or a list of several files (joined with commas)."
    inputBinding:
      prefix: "--themisto"
      itemSeparator: ","
  - id: group_indicators
    type: File
    doc: "Group indicators for the pseudoalignment reference."
    inputBinding:
      prefix: "-i"
  - id: output_prefix
    type: string
    doc: "Prefix for output files written from mSWEEP (the abundances go to <prefix>_abundances.txt)."
    inputBinding:
      prefix: "-o"
  - id: bin_reads
    type: ['null', boolean]
    doc: "Run the mGEMS binning algorithm and write bins to the directory -o points to."
    inputBinding:
      prefix: "--bin-reads"
  - id: target_groups
    type: ['null', string]
    doc: "Only extract these groups, supply as comma separated list."
    inputBinding:
      prefix: "--target-groups"
  - id: min_abundance
    type: ['null', double]
    doc: "Only extract groups that have a relative abundance higher than this value (default: 0)."
    inputBinding:
      prefix: "--min-abundance"
  - id: write_probs
    type: ['null', boolean]
    doc: "Write the estimated read-to-group probabilities to a file with _probs.tsv suffix."
    inputBinding:
      prefix: "--write-probs"
  - id: print_probs
    type: ['null', boolean]
    doc: "Print the read equivalence class probabilities to cout even if -o is given."
    inputBinding:
      prefix: "--print-probs"
  - id: write_likelihood
    type: ['null', boolean]
    doc: "Write the internal likelihood matrix to a file with _likelihoods.txt suffix."
    inputBinding:
      prefix: "--write-likelihood"
  - id: write_likelihood_bitseq
    type: ['null', boolean]
    doc: "Write the likelihoods in a format that can be parsed by BitSeq."
    inputBinding:
      prefix: "--write-likelihood-bitseq"
  - id: compress
    type: ['null', string]
    doc: "Compress all output files using the given algorithm (one of z, bz2, lzma)."
    inputBinding:
      prefix: "--compress"
  - id: compression_level
    type: ['null', int]
    doc: "Compression level (0-9; default: 6)."
    inputBinding:
      prefix: "--compression-level"
  - id: themisto_mode
    type: ['null', string]
    doc: "How to merge pseudoalignments for paired-end reads (intersection, union, or unpaired; default: intersection)."
    inputBinding:
      prefix: "--themisto-mode"
  - id: read_likelihood
    type: ['null', File]
    doc: "Path to a precomputed likelihood file written with --write-likelihood. Cannot be used with --bin-reads."
    inputBinding:
      prefix: "--read-likelihood"
  - id: threads
    type: ['null', int]
    doc: "How many threads to use in abundance estimation (default: 1)."
    inputBinding:
      prefix: "-t"
  - id: no_fit_model
    type: ['null', boolean]
    doc: "Do not estimate the abundances. Useful if only the likelihood matrix is required."
    inputBinding:
      prefix: "--no-fit-model"
  - id: max_iters
    type: ['null', int]
    doc: "Maximum number of iterations to run the abundance estimation optimizer for (default: 5000)."
    inputBinding:
      prefix: "--max-iters"
  - id: tol
    type: ['null', double]
    doc: "Optimization terminates when the bound changes by less than the given tolerance (default: 0.000001)."
    inputBinding:
      prefix: "--tol"
  - id: algorithm
    type: ['null', string]
    doc: "Algorithm for abundance estimation (one of rcggpu, emgpu, rcgcpu; default: rcgcpu)."
    inputBinding:
      prefix: "--algorithm"
  - id: emprecision
    type: ['null', string]
    doc: "Precision to use for the emgpu algorithm (one of float, double; default: double)."
    inputBinding:
      prefix: "--emprecision"
  - id: iters
    type: ['null', int]
    doc: "Number of times to rerun estimation with bootstrapped alignments (default: 0)."
    inputBinding:
      prefix: "--iters"
  - id: seed
    type: ['null', int]
    doc: "Seed for the random generator used in bootstrapping (default: random)."
    inputBinding:
      prefix: "--seed"
  - id: bootstrap_count
    type: ['null', int]
    doc: "How many pseudoalignments to resample when bootstrapping (default: number of reads)."
    inputBinding:
      prefix: "--bootstrap-count"
  - id: beta_binomial_mean
    type: ['null', double]
    doc: "Mean for the beta-binomial component (default: 0.65)."
    inputBinding:
      prefix: "-q"
  - id: beta_binomial_dispersion
    type: ['null', double]
    doc: "Dispersion term for the beta-binomial component (default: 0.01)."
    inputBinding:
      prefix: "-e"
  - id: alphas
    type: ['null', string]
    doc: "Prior counts for the relative abundances, comma-separated nonzero values (default: all 1.0)."
    inputBinding:
      prefix: "--alphas"
  - id: zero_inflation
    type: ['null', double]
    doc: "Likelihood of an observation that contains 0 pseudoalignments against a reference group (default: 0.01)."
    inputBinding:
      prefix: "--zero-inflation"
  - id: run_rate
    type: ['null', boolean]
    doc: "Calculate relative reliability for each abundance estimate using RATE."
    inputBinding:
      prefix: "--run-rate"
  - id: min_hits
    type: ['null', int]
    doc: "Only consider target groups that have at least this many reads align to any sequence in them (default: 0)."
    inputBinding:
      prefix: "--min-hits"
  - id: verbose
    type: ['null', boolean]
    doc: "Print status messages to cerr."
    inputBinding:
      prefix: "--verbose"
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Result files written with the output prefix (abundances, probabilities, likelihoods, bootstrap results).
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msweep:2.2.1--h503566f_1
