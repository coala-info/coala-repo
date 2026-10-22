cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmercounter
label: skesa_kmercounter
doc: "Count k-mers in reads and write a de Bruijn graph, a text k-mer list or a histogram\n\nTool homepage: https://github.com/ncbi/SKESA"
inputs:
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
  - id: kmer
    type:
      - 'null'
      - int
    doc: 'Kmer length [default: 21]'
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
  - id: no_strand_info
    type:
      - 'null'
      - boolean
    doc: 'Create graph with disabled directional filtering'
    inputBinding:
      position: 101
      prefix: --no_strand_info
  - id: estimated_kmers
    type:
      - 'null'
      - int
    doc: 'Estimated number of distinct kmers for bloom filter (millions) for hash count [default: 100]'
    inputBinding:
      position: 101
      prefix: --estimated_kmers
  - id: skip_bloom_filter
    type:
      - 'null'
      - boolean
    doc: 'Don''t do bloom filter; use --estimated_kmers as the hash table size for hash count'
    inputBinding:
      position: 101
      prefix: --skip_bloom_filter
  - id: dbg_out_path
    type:
      - 'null'
      - string
    doc: 'de Bruijn graph output'
    inputBinding:
      position: 102
      prefix: --dbg_out
  - id: text_out_path
    type:
      - 'null'
      - string
    doc: 'Text kmer output'
    inputBinding:
      position: 102
      prefix: --text_out
  - id: hist_path
    type:
      - 'null'
      - string
    doc: 'File for histogram'
    inputBinding:
      position: 102
      prefix: --hist
  - id: cores
    type:
      - 'null'
      - int
    doc: 'Number of cores to use (default all) [default: 0]'
    inputBinding:
      position: 101
      prefix: --cores
outputs:
  - id: dbg_out
    type:
      - 'null'
      - File
    doc: 'de Bruijn graph output'
    outputBinding:
      glob: $(inputs.dbg_out_path)
  - id: text_out
    type:
      - 'null'
      - File
    doc: 'Text kmer output'
    outputBinding:
      glob: $(inputs.text_out_path)
  - id: hist
    type:
      - 'null'
      - File
    doc: 'File for histogram'
    outputBinding:
      glob: $(inputs.hist_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skesa:2.5.1--h077b44d_3
