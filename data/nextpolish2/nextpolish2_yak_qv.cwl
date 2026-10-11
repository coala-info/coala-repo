cwlVersion: v1.2
class: CommandLineTool
baseCommand: [yak, qv]
label: nextpolish2_yak_qv
doc: "Estimate assembly consensus quality value (QV) by comparing assembly k-mers with a k-mer hash table of short reads\n\nTool homepage: https://github.com/Nextomics/NextPolish2"
inputs:
  - id: min_seq_len
    type: ['null', string]
    doc: min sequence length [0]
    inputBinding:
      position: 1
      prefix: -l
  - id: min_kmer_fraction
    type: ['null', float]
    doc: min k-mer fraction [0.5]
    inputBinding:
      position: 1
      prefix: -f
  - id: false_positive_rate
    type: ['null', float]
    doc: false positive rate [0]
    inputBinding:
      position: 1
      prefix: -e
  - id: print_per_sequence
    type: ['null', boolean]
    doc: print QV for each sequence
    inputBinding:
      position: 1
      prefix: -p
  - id: print_wrong_kmers
    type: ['null', boolean]
    doc: print the positions of wrong k-mers
    inputBinding:
      position: 1
      prefix: -E
  - id: threads
    type: ['null', int]
    doc: number of threads [4]
    inputBinding:
      position: 1
      prefix: -t
  - id: batch_size
    type: ['null', string]
    doc: batch size [1g]
    inputBinding:
      position: 1
      prefix: -K
  - id: kmer_hash
    type: File
    doc: k-mer hash table made by yak count
    inputBinding:
      position: 2
  - id: sequences
    type: File
    doc: assembly sequences in FASTA/FASTQ format (optionally gzipped)
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: per-sequence QV lines (stdout)
  - id: stderr
    type: stderr
    doc: summary log with the overall QV (stderr)
stdout: yak_qv.out
stderr: yak_qv.err
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextpolish2:0.2.2--h74ec884_0
