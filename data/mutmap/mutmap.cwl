cwlVersion: v1.2
class: CommandLineTool
baseCommand: mutmap
label: mutmap
doc: "MutMap version 2.3.9\n\nTool homepage: https://github.com/YuSugihara/MutMap"
inputs:
  - id: adapter
    type:
      - 'null'
      - File
    doc: "FASTA file containing adapter sequences. This option\n                 \
      \    is used when \"-T\" is specified for trimming."
    inputBinding:
      position: 101
      prefix: --adapter
  - id: adjust_mq
    type:
      - 'null'
      - int
    doc: "Adjust the mapping quality for mpileup. The default\n                  \
      \   setting is optimized for BWA."
    inputBinding:
      position: 101
      prefix: --adjust-MQ
  - id: bulk
    type:
      type: array
      items: File
    doc: "FASTQ or BAM file of mutant bulk. If specifying\n                     FASTQ,
      separate paired-end files with a comma,\n                     e.g., -b fastq1,fastq2.
      This option can be\n                     used multiple times."
    inputBinding:
      position: 101
      prefix: --bulk
  - id: cultivar
    type:
      type: array
      items: File
    doc: "FASTQ or BAM file of cultivar. If specifying\n                     FASTQ,
      separate paired-end files with a comma,\n                     e.g., -c fastq1,fastq2.
      This option can be\n                     used multiple times."
    inputBinding:
      position: 101
      prefix: --cultivar
  - id: dot_color
    type:
      - 'null'
      - string
    doc: Color of the dots in plots.
    inputBinding:
      position: 101
      prefix: --dot-color
  - id: line_colors
    type:
      - 'null'
      - string
    doc: "Colors for threshold lines in plots. Specify a\n                     comma-separated
      list in the order of SNP-index,\n                     p95, and p99."
    inputBinding:
      position: 101
      prefix: --line-colors
  - id: max_depth
    type:
      - 'null'
      - int
    doc: "Maximum depth of variants to be used. This cutoff\n                    \
      \ applies to both the cultivar and the bulk."
    inputBinding:
      position: 101
      prefix: --max-depth
  - id: mem
    type:
      - 'null'
      - string
    doc: Maximum memory per thread when sorting BAM files; suffixes K/M/G are 
      recognized.
    inputBinding:
      position: 101
      prefix: --mem
  - id: min_bq
    type:
      - 'null'
      - int
    doc: Minimum base quality for mpileup.
    inputBinding:
      position: 101
      prefix: --min-BQ
  - id: min_depth
    type:
      - 'null'
      - int
    doc: "Minimum depth of variants to be used. This cutoff\n                    \
      \ applies to both the cultivar and the bulk."
    inputBinding:
      position: 101
      prefix: --min-depth
  - id: min_mq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality for mpileup.
    inputBinding:
      position: 101
      prefix: --min-MQ
  - id: n_bulk
    type: int
    doc: Number of individuals in the mutant bulk.
    inputBinding:
      position: 101
      prefix: --N-bulk
  - id: n_rep
    type:
      - 'null'
      - int
    doc: "Number of replicates for simulations to generate\n                     null
      distribution."
    inputBinding:
      position: 101
      prefix: --N-rep
  - id: reference_fasta
    type: File
    doc: Reference FASTA file.
    inputBinding:
      position: 101
      prefix: --ref
  - id: snpeff
    type:
      - 'null'
      - string
    doc: "Predict causal variants using SnpEff. Check\n                     available
      databases in SnpEff."
    inputBinding:
      position: 101
      prefix: --snpEff
  - id: step
    type:
      - 'null'
      - int
    doc: Step size in kilobases (kb).
    inputBinding:
      position: 101
      prefix: --step
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads. If a value less than 1 is specified,\n              \
      \       MutMap will use the maximum available threads."
    inputBinding:
      position: 101
      prefix: --threads
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Trim FASTQ files using Trimmomatic.
    inputBinding:
      position: 101
      prefix: --trim
  - id: trim_params
    type:
      - 'null'
      - string
    doc: "Parameters for Trimmomatic. Input parameters\n                     must
      be comma-separated in the following order:\n                     Phred score,
      ILLUMINACLIP, LEADING, TRAILING,\n                      SLIDINGWINDOW, MINLEN.
      To remove Illumina adapters,\n                     specify the adapter FASTA
      file with \"--adapter\".\n                     If not specified, adapter trimming
      will be skipped."
    inputBinding:
      position: 101
      prefix: --trim-params
  - id: window
    type:
      - 'null'
      - int
    doc: Window size in kilobases (kb).
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: out_dir
    type: Directory
    doc: "Output directory. The specified directory must not\n                   \
      \  already exist."
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mutmap:2.3.9--pyhdfd78af_0
