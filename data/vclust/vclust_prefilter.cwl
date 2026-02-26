cwlVersion: v1.2
class: CommandLineTool
baseCommand: vclust prefilter
label: vclust_prefilter
doc: "vclust prefilter\n\nTool homepage: https://github.com/refresh-bio/vclust"
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    doc: "Process a multifasta file in smaller batches of <int> FASTA sequences.\n\
      \                            This option reduces memory at the expense of speed.
      By default, no batch"
    default: 0
    inputBinding:
      position: 101
      prefix: --batch-size
  - id: input_file
    type: File
    doc: Input FASTA file or directory of files (gzipped or uncompressed)
    inputBinding:
      position: 101
      prefix: --in
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Size of k-mer for Kmer-db
    default: 25
    inputBinding:
      position: 101
      prefix: --k
  - id: kmers_fraction
    type:
      - 'null'
      - float
    doc: "Fraction of k-mers to analyze in each genome (0-1). A lower value\n    \
      \                        reduces RAM usage and speeds up processing. By default,
      all k-mers"
    default: 1.0
    inputBinding:
      position: 101
      prefix: --kmers-fraction
  - id: max_seqs
    type:
      - 'null'
      - int
    doc: "Maximum number of sequences allowed to pass the prefilter per query.\n \
      \                           Only the sequences with the highest identity to
      the query are reported.\n                            This option reduces RAM
      usage and speeds up processing (affects\n                            sensitivity).
      By default, all sequences that pass the prefilter are\n                    \
      \        reported"
    default: 0
    inputBinding:
      position: 101
      prefix: --max-seqs
  - id: min_ident
    type:
      - 'null'
      - float
    doc: "Minimum sequence identity (0-1) between two genomes. Calculated based on\n\
      \                            the shorter sequence"
    default: 0.7
    inputBinding:
      position: 101
      prefix: --min-ident
  - id: min_kmers
    type:
      - 'null'
      - int
    doc: Minimum number of shared k-mers between two genomes
    default: 20
    inputBinding:
      position: 101
      prefix: --min-kmers
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Verbosity level [1]:\n                            0: Errors only\n     \
      \                       1: Info\n                            2: Debug"
    default: 1
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: Output filename
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vclust:1.3.1--py311he264feb_1
