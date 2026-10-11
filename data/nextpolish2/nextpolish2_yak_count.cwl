cwlVersion: v1.2
class: CommandLineTool
baseCommand: [yak, count]
label: nextpolish2_yak_count
doc: "Count k-mers in sequencing reads and dump the count hash table (yak format) used by nextPolish2\n\nTool homepage: https://github.com/Nextomics/NextPolish2"
inputs:
  - id: kmer_size
    type: ['null', int]
    doc: k-mer size [31]
    inputBinding:
      position: 1
      prefix: -k
  - id: prefix_length
    type: ['null', int]
    doc: prefix length [10]
    inputBinding:
      position: 1
      prefix: -p
  - id: bloom_bits
    type: ['null', int]
    doc: set Bloom filter size to 2**INT bits; 0 to disable [0]
    inputBinding:
      position: 1
      prefix: -b
  - id: hash_functions
    type: ['null', int]
    doc: use INT hash functions for Bloom filter [4]
    inputBinding:
      position: 1
      prefix: -H
  - id: threads
    type: ['null', int]
    doc: number of worker threads [4]
    inputBinding:
      position: 1
      prefix: -t
  - id: chunk_size
    type: ['null', string]
    doc: chunk size [100m]
    inputBinding:
      position: 1
      prefix: -K
  - id: output_file_path
    type: string
    doc: dump the count hash table to FILE
    inputBinding:
      position: 1
      prefix: -o
  - id: reads
    type: File
    doc: input reads in FASTA/FASTQ format (optionally gzipped)
    inputBinding:
      position: 2
  - id: reads_2
    type: ['null', File]
    doc: second input file (use the same file twice for single-pass counting of one dataset)
    inputBinding:
      position: 3
outputs:
  - id: output_file
    type: File
    doc: k-mer count hash table
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextpolish2:0.2.2--h74ec884_0
