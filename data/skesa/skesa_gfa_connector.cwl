cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfa_connector
label: skesa_gfa_connector
doc: "Connect contigs into a GFA graph using reads\n\nTool homepage: https://github.com/ncbi/SKESA"
inputs:
  - id: cores
    type:
      - 'null'
      - int
    doc: 'Number of cores to use (default all) [default: 0]'
    inputBinding:
      position: 101
      prefix: --cores
  - id: estimated_kmers
    type:
      - 'null'
      - int
    doc: 'Estimated number of distinct kmers for bloom filter (millions) [default: 100]'
    inputBinding:
      position: 101
      prefix: --estimated_kmers
  - id: skip_bloom_filter
    type:
      - 'null'
      - boolean
    doc: 'Don''t do bloom filter; use --estimated_kmers as the hash table size'
    inputBinding:
      position: 101
      prefix: --skip_bloom_filter
  - id: reads
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Input fasta/fastq file(s) for reads, could be gzipped. Files are joined with commas into one --reads value (use two files for a read pair).'
    inputBinding:
      position: 101
      prefix: --reads
      itemSeparator: ','
  - id: use_paired_ends
    type:
      - 'null'
      - boolean
    doc: 'Indicates that single (not comma separated) fasta/fastq files contain paired reads'
    inputBinding:
      position: 101
      prefix: --use_paired_ends
  - id: contigs
    type:
      - 'null'
      - File
    doc: 'Input file with contigs'
    inputBinding:
      position: 101
      prefix: --contigs
  - id: gfa_path
    type:
      - 'null'
      - string
    doc: 'GFA graph output (stdout if not specified)'
    inputBinding:
      position: 102
      prefix: --gfa
  - id: dbg
    type:
      - 'null'
      - File
    doc: 'Input de Bruijn graph (optional)'
    inputBinding:
      position: 101
      prefix: --dbg
  - id: csv_path
    type:
      - 'null'
      - string
    doc: 'CSV file ouput (optional)'
    inputBinding:
      position: 102
      prefix: --csv
  - id: contig_color
    type:
      - 'null'
      - string
    doc: 'Color for contigs [default: Purple]'
    inputBinding:
      position: 101
      prefix: --contig_color
  - id: connector_color
    type:
      - 'null'
      - string
    doc: 'Color for connectors [default: Lime Green]'
    inputBinding:
      position: 101
      prefix: --connector_color
  - id: kmer
    type:
      - 'null'
      - int
    doc: 'Kmer length for assembly'
    inputBinding:
      position: 101
      prefix: --kmer
  - id: min_count
    type:
      - 'null'
      - int
    doc: 'Minimal count for kmers retained for comparing alternate choices [default: 2]'
    inputBinding:
      position: 101
      prefix: --min_count
  - id: vector_percent
    type:
      - 'null'
      - float
    doc: 'Percentage of reads containing 19-mer for the 19-mer to be considered a vector (1. disables) [float (0,1]] [default: 0.05]'
    inputBinding:
      position: 101
      prefix: --vector_percent
  - id: fraction
    type:
      - 'null'
      - float
    doc: 'Threshold for extension [default: 0.1]'
    inputBinding:
      position: 101
      prefix: --fraction
  - id: entropy
    type:
      - 'null'
      - float
    doc: 'Minimal entropy for a seed kmer [default: 0.51]'
    inputBinding:
      position: 101
      prefix: --entropy
  - id: ext_len
    type:
      - 'null'
      - int
    doc: 'Maximal length for extension [default: 2000]'
    inputBinding:
      position: 101
      prefix: --ext_len
  - id: not_aligned_len
    type:
      - 'null'
      - int
    doc: 'Not aligned read length for break count [default: 10]'
    inputBinding:
      position: 101
      prefix: --not_aligned_len
  - id: not_aligned_count
    type:
      - 'null'
      - int
    doc: 'Number of not aligned reads to make a break [default: 3]'
    inputBinding:
      position: 101
      prefix: --not_aligned_count
  - id: aligned_count
    type:
      - 'null'
      - int
    doc: 'Number of aligned reads to confirm a connection [default: 2]'
    inputBinding:
      position: 101
      prefix: --aligned_count
  - id: max_path
    type:
      - 'null'
      - int
    doc: 'Maximal number of paths allowed in 1 step of filtering [default: 1000]'
    inputBinding:
      position: 101
      prefix: --max_path
  - id: no_filter_by_reads
    type:
      - 'null'
      - boolean
    doc: 'Don''t use full length reads for variants filtering'
    inputBinding:
      position: 101
      prefix: --no_filter_by_reads
  - id: no_filter_by_pairs
    type:
      - 'null'
      - boolean
    doc: 'Don''t use mate pairs for variants filtering'
    inputBinding:
      position: 101
      prefix: --no_filter_by_pairs
outputs:
  - id: gfa
    type:
      - 'null'
      - File
    doc: 'GFA graph output (stdout if not specified)'
    outputBinding:
      glob: $(inputs.gfa_path)
  - id: csv
    type:
      - 'null'
      - File
    doc: 'CSV file ouput (optional)'
    outputBinding:
      glob: $(inputs.csv_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skesa:2.5.1--h077b44d_3
