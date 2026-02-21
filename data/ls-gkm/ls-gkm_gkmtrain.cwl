cwlVersion: v1.2
class: CommandLineTool
baseCommand: gkmtrain
label: ls-gkm_gkmtrain
doc: "Train a Gapped K-mer Support Vector Machine (gkm-SVM) model using positive and
  negative training sequences.\n\nTool homepage: https://github.com/Dongwon-Lee/lsgkm"
inputs:
  - id: posfile
    type: File
    doc: Positive sequence file (fasta format)
    inputBinding:
      position: 1
  - id: negfile
    type: File
    doc: Negative sequence file (fasta format)
    inputBinding:
      position: 2
  - id: cross_validation
    type:
      - 'null'
      - int
    doc: n-fold cross-validation
    default: 3
    inputBinding:
      position: 103
      prefix: -v
  - id: epsilon
    type:
      - 'null'
      - float
    doc: Epsilon for gkm kernel
    default: 0.01
    inputBinding:
      position: 103
      prefix: -e
  - id: informative_columns
    type:
      - 'null'
      - int
    doc: Number of informative columns
    default: 7
    inputBinding:
      position: 103
      prefix: -k
  - id: kernel_type
    type:
      - 'null'
      - int
    doc: 'Kernel type: 1: gkm, 2: l-gkm, 4: wgkm (recommended), 5: l-wgkm'
    default: 4
    inputBinding:
      position: 103
      prefix: -t
  - id: max_gaps
    type:
      - 'null'
      - int
    doc: Maximum number of gaps
    default: 2
    inputBinding:
      position: 103
      prefix: -g
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: Maximum number of mismatches
    default: 3
    inputBinding:
      position: 103
      prefix: -d
  - id: min_kmer_count
    type:
      - 'null'
      - float
    doc: Minimum count of a k-mer
    default: 50.0
    inputBinding:
      position: 103
      prefix: -m
  - id: pos_weight
    type:
      - 'null'
      - float
    doc: Weight for positive sequences
    default: 1.0
    inputBinding:
      position: 103
      prefix: -w
  - id: regularization_c
    type:
      - 'null'
      - float
    doc: Regularization parameter C
    default: 1.0
    inputBinding:
      position: 103
      prefix: -c
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel processing
    default: 1
    inputBinding:
      position: 103
      prefix: -T
  - id: word_length
    type:
      - 'null'
      - int
    doc: Word length
    default: 11
    inputBinding:
      position: 103
      prefix: -l
outputs:
  - id: outprefix
    type: File
    doc: Output file prefix
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ls-gkm:0.1.1--h9948957_0
