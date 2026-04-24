cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yak
  - count
label: yak_count
doc: "Count k-mers in FASTA files\n\nTool homepage: https://github.com/lh3/yak"
inputs:
  - id: input_fa
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: input_fa_2
    type:
      - 'null'
      - File
    doc: Another input FASTA file
    inputBinding:
      position: 2
  - id: bloom_filter_bits
    type:
      - 'null'
      - int
    doc: set Bloom filter size to 2**INT bits; 0 to disable
    inputBinding:
      position: 103
      prefix: -b
  - id: chunk_size
    type:
      - 'null'
      - string
    doc: chunk size
    inputBinding:
      position: 103
      prefix: -K
  - id: hash_functions
    type:
      - 'null'
      - int
    doc: use INT hash functions for Bloom filter
    inputBinding:
      position: 103
      prefix: -H
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size
    inputBinding:
      position: 103
      prefix: -k
  - id: prefix_length
    type:
      - 'null'
      - int
    doc: prefix length
    inputBinding:
      position: 103
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: number of worker threads
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: dump the count hash table to FILE
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yak:0.1--hed695b0_0
