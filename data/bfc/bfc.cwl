cwlVersion: v1.2
class: CommandLineTool
baseCommand: bfc
label: bfc
doc: "Corrects sequencing errors in FASTQ files using a Bloom filter and k-mer counting.\n\
  \nTool homepage: https://github.com/Wilfred/bfc"
inputs:
  - id: to_count_fq
    type: File
    doc: FASTQ file to count k-mers from.
    inputBinding:
      position: 1
  - id: to_correct_fq
    type:
      - 'null'
      - File
    doc: FASTQ file to correct errors in.
    inputBinding:
      position: 2
  - id: bloom_filter_size_bits
    type:
      - 'null'
      - int
    doc: Set Bloom filter size to pow(2,INT) bits.
    inputBinding:
      position: 103
      prefix: -b
  - id: drop_unique_kmer_reads
    type:
      - 'null'
      - boolean
    doc: Drop reads containing unique k-mers.
    inputBinding:
      position: 103
      prefix: '-1'
  - id: dump_hash_table
    type:
      - 'null'
      - File
    doc: Dump hash table to FILE.
    inputBinding:
      position: 103
      prefix: -d
  - id: force_fasta_output
    type:
      - 'null'
      - boolean
    doc: Force FASTA output.
    inputBinding:
      position: 103
      prefix: -Q
  - id: genome_size
    type:
      - 'null'
      - float
    doc: Approximate genome size (k/m/g allowed; change -k and -b).
    inputBinding:
      position: 103
      prefix: -s
  - id: hash_functions
    type:
      - 'null'
      - int
    doc: Use INT hash functions for Bloom filter.
    inputBinding:
      position: 103
      prefix: -H
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length.
    inputBinding:
      position: 103
      prefix: -k
  - id: min_kmer_coverage
    type:
      - 'null'
      - int
    doc: Minimum k-mer coverage.
    inputBinding:
      position: 103
      prefix: -c
  - id: refine_corrected_reads
    type:
      - 'null'
      - boolean
    doc: Refine bfc-corrected reads.
    inputBinding:
      position: 103
      prefix: -R
  - id: restore_hash_table
    type:
      - 'null'
      - File
    doc: Restore hash table from FILE.
    inputBinding:
      position: 103
      prefix: -r
  - id: skip_error_correction
    type:
      - 'null'
      - boolean
    doc: Skip error correction.
    inputBinding:
      position: 103
      prefix: -E
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 103
      prefix: -t
  - id: window_size
    type:
      - 'null'
      - int
    doc: No more than 5 ec or 2 highQ ec in INT-bp window.
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bfc:r181--h577a1d6_12
stdout: bfc.out
