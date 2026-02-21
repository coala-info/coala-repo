cwlVersion: v1.2
class: CommandLineTool
baseCommand: bft
label: bloomfiltertrie_bft
doc: "Bloom Filter Trie (BFT) tool for building, loading, and querying k-mer indexes
  from genome files.\n\nTool homepage: https://github.com/GuillaumeHolley/BloomFilterTrie"
inputs:
  - id: subcommand
    type: string
    doc: 'The action to perform: build or load'
    inputBinding:
      position: 1
  - id: file_bft
    type:
      - 'null'
      - File
    doc: BFT file to load (required for load subcommand)
    inputBinding:
      position: 2
  - id: k
    type:
      - 'null'
      - int
    doc: k-mer size (required for build)
    inputBinding:
      position: 3
  - id: kmer_mode
    type:
      - 'null'
      - string
    doc: 'K-mer representation mode: kmers or kmers_comp'
    inputBinding:
      position: 4
  - id: list_genome_files
    type:
      - 'null'
      - File
    doc: File containing a list of genome files
    inputBinding:
      position: 5
  - id: add_genomes
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Add genomes to an existing BFT: requires {kmers|kmers_comp} list_genome_files
      output_file'
    inputBinding:
      position: 106
      prefix: -add_genomes
  - id: extract_kmers
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Extract k-mers: requires {kmers|kmers_comp} compressed_kmers_file'
    inputBinding:
      position: 106
      prefix: -extract_kmers
  - id: query_branching
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Query branching: requires {kmers|kmers_comp} list_kmer_files'
    inputBinding:
      position: 106
      prefix: -query_branching
  - id: query_kmers
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Query k-mers: requires {kmers|kmers_comp} list_kmer_files'
    inputBinding:
      position: 106
      prefix: -query_kmers
  - id: query_sequences
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Query sequences: requires threshold {canonical|non_canonical} list_sequence_files'
    inputBinding:
      position: 106
      prefix: -query_sequences
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BFT file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bloomfiltertrie:0.8.7--h779adbc_2
