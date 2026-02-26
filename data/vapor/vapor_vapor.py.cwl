cwlVersion: v1.2
class: CommandLineTool
baseCommand: vapor.py
label: vapor_vapor.py
doc: "Do some viral classification!\n\nTool homepage: https://github.com/connor-lab/vapor"
inputs:
  - id: debug_query
    type:
      - 'null'
      - string
    doc: Debug query
    default: all reads
    inputBinding:
      position: 101
      prefix: --debug_query
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Fasta file
    inputBinding:
      position: 101
      prefix: -fa
  - id: fastq_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Fastq file/files
    inputBinding:
      position: 101
      prefix: -fq
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Kmer Length [5 > int > 30, default=21]
    default: 21
    inputBinding:
      position: 101
      prefix: --k
  - id: low_mem
    type:
      - 'null'
      - boolean
    doc: Use low memory mode
    inputBinding:
      position: 101
      prefix: --low_mem
  - id: min_kmer_cov
    type:
      - 'null'
      - int
    doc: Minimum coverage kmer culling
    default: 5
    inputBinding:
      position: 101
      prefix: --min_kmer_cov
  - id: min_kmer_prop
    type:
      - 'null'
      - float
    doc: Minimum proportion of matched kmers allowed for queries
    default: 0.1
    inputBinding:
      position: 101
      prefix: --min_kmer_prop
  - id: nocache
    type:
      - 'null'
      - boolean
    doc: Disable caching
    inputBinding:
      position: 101
      prefix: --nocache
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode
    inputBinding:
      position: 101
      prefix: --quiet
  - id: return_best_n
    type:
      - 'null'
      - int
    doc: Return the best N sequences
    inputBinding:
      position: 101
      prefix: --return_best_n
  - id: return_seqs
    type:
      - 'null'
      - boolean
    doc: Return sequences
    inputBinding:
      position: 101
      prefix: --return_seqs
  - id: subsample
    type:
      - 'null'
      - int
    doc: Number of reads to subsample
    default: all reads
    inputBinding:
      position: 101
      prefix: --subsample
  - id: threshold
    type:
      - 'null'
      - float
    doc: Read kmer filtering threshold [0 > float > 1, default=0.2]
    default: 0.2
    inputBinding:
      position: 101
      prefix: --threshold
  - id: top_seed_frac
    type:
      - 'null'
      - float
    doc: Fraction of best seeds to extend
    default: 0.2
    inputBinding:
      position: 101
      prefix: --top_seed_frac
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix to write full output to, stout by default
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vapor:1.0.3--pyhdfd78af_0
