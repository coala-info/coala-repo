cwlVersion: v1.2
class: CommandLineTool
baseCommand: qtlseq
label: qtlseq
doc: "QTL-seq version 2.2.9\n\nTool homepage: https://github.com/YuSugihara/QTL-seq"
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
    default: 50
    inputBinding:
      position: 101
      prefix: --adjust-MQ
  - id: bulk1
    type:
      type: array
      items: File
    doc: "FASTQ or BAM file of bulk 1. If specifying\n                     FASTQ,
      separate paired-end files with a comma,\n                     e.g., -b1 fastq1,fastq2.
      This option can be\n                     used multiple times."
    inputBinding:
      position: 101
      prefix: --bulk1
  - id: bulk2
    type:
      type: array
      items: File
    doc: "FASTQ or BAM file of bulk 2. If specifying\n                     FASTQ,
      separate paired-end files with a comma,\n                     e.g., -b2 fastq1,fastq2.
      This option can be\n                     used multiple times."
    inputBinding:
      position: 101
      prefix: --bulk2
  - id: dot_colors
    type:
      - 'null'
      - string
    doc: "Colors for dots in plots. Specify a\n                     comma-separated
      list in the order of bulk1,\n                     bulk2, and delta."
    default: '"#74D3AE,#FFBE0B,#B3B8DD"'
    inputBinding:
      position: 101
      prefix: --dot-colors
  - id: filial
    type:
      - 'null'
      - int
    doc: "Filial generation. This parameter must be greater\n                    \
      \ than 1."
    default: 2
    inputBinding:
      position: 101
      prefix: --filial
  - id: line_colors
    type:
      - 'null'
      - string
    doc: "Colors for threshold lines in plots. Specify a\n                     comma-separated
      list in the order of SNP-index,\n                     p95, and p99."
    default: '"#C3310F,#009E72,#FDB003"'
    inputBinding:
      position: 101
      prefix: --line-colors
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum depth of variants to be used.
    default: 250
    inputBinding:
      position: 101
      prefix: --max-depth
  - id: mem
    type:
      - 'null'
      - string
    doc: "Maximum memory per thread when sorting BAM files;\n                    \
      \ suffixes K/M/G are recognized."
    default: 1G
    inputBinding:
      position: 101
      prefix: --mem
  - id: min_bq
    type:
      - 'null'
      - int
    doc: Minimum base quality for mpileup.
    default: 18
    inputBinding:
      position: 101
      prefix: --min-BQ
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth of variants to be used.
    default: 8
    inputBinding:
      position: 101
      prefix: --min-depth
  - id: min_mq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality for mpileup.
    default: 40
    inputBinding:
      position: 101
      prefix: --min-MQ
  - id: n_bulk1
    type: int
    doc: Number of individuals in bulk 1.
    inputBinding:
      position: 101
      prefix: --N-bulk1
  - id: n_bulk2
    type: int
    doc: Number of individuals in bulk 2.
    inputBinding:
      position: 101
      prefix: --N-bulk2
  - id: n_rep
    type:
      - 'null'
      - int
    doc: "Number of replicates for simulations to generate\n                     null
      distribution."
    default: 5000
    inputBinding:
      position: 101
      prefix: --N-rep
  - id: parent
    type:
      type: array
      items: File
    doc: "FASTQ or BAM file of the parent. If specifying\n                     FASTQ,
      separate paired-end files with a comma,\n                     e.g., -p fastq1,fastq2.
      This option can be\n                     used multiple times."
    inputBinding:
      position: 101
      prefix: --parent
  - id: ref
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
    default: 100
    inputBinding:
      position: 101
      prefix: --step
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads. If a value less than 1 is specified,\n              \
      \       QTL-seq will use the maximum available threads."
    default: 2
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
      ILLUMINACLIP, LEADING, TRAILING, \n                     SLIDINGWINDOW, MINLEN.
      To remove Illumina adapters,\n                     specify the adapter FASTA
      file with \"--adapter\".\n                     If not specified, adapter trimming
      will be skipped."
    default: 33,<ADAPTER_FASTA>:2:30:10,20,20,4:15,75
    inputBinding:
      position: 101
      prefix: --trim-params
  - id: window
    type:
      - 'null'
      - int
    doc: Window size in kilobases (kb).
    default: 2000
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
    dockerPull: quay.io/biocontainers/qtlseq:2.2.9--pyhdfd78af_0
