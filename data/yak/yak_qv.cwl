cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yak
  - qv
label: yak_qv
doc: "Calculate k-mer quality values (QV) for sequences.\n\nTool homepage: https://github.com/lh3/yak"
inputs:
  - id: kmer_hash
    type: File
    doc: Input k-mer hash file
    inputBinding:
      position: 1
  - id: seq_fa
    type: File
    doc: Input FASTA file with sequences
    inputBinding:
      position: 2
  - id: batch_size
    type:
      - 'null'
      - string
    doc: Batch size
    default: 1g
    inputBinding:
      position: 103
      prefix: -K
  - id: false_positive_rate
    type:
      - 'null'
      - float
    doc: False positive rate
    default: '4e-05'
    inputBinding:
      position: 103
      prefix: -e
  - id: min_kmer_fraction
    type:
      - 'null'
      - float
    doc: Minimum k-mer fraction
    default: 0.5
    inputBinding:
      position: 103
      prefix: -f
  - id: min_sequence_length
    type:
      - 'null'
      - int
    doc: Minimum sequence length
    default: 0
    inputBinding:
      position: 103
      prefix: -l
  - id: print_qv_per_sequence
    type:
      - 'null'
      - boolean
    doc: Print QV for each sequence
    inputBinding:
      position: 103
      prefix: -p
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 4
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yak:0.1--hed695b0_0
stdout: yak_qv.out
