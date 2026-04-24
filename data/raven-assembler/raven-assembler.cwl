cwlVersion: v1.2
class: CommandLineTool
baseCommand: raven
label: raven-assembler
doc: "Raven is a de novo assembler for long reads (PacBio, Oxford Nanopore). It is
  designed as a modular pipeline for assembling genomic datasets.\n\nTool homepage:
  https://github.com/lbcb-sci/raven"
inputs:
  - id: sequences
    type:
      type: array
      items: File
    doc: Input file in FASTA/FASTQ format (can be compressed with gzip)
    inputBinding:
      position: 1
  - id: disable_checkpoints
    type:
      - 'null'
      - boolean
    doc: disable checkpoint file creation
    inputBinding:
      position: 102
      prefix: --disable-checkpoints
  - id: frequency
    type:
      - 'null'
      - float
    doc: threshold for ignoring most frequent kmers
    inputBinding:
      position: 102
      prefix: --frequency
  - id: kmer_len
    type:
      - 'null'
      - int
    doc: length of kmers used for error correction
    inputBinding:
      position: 102
      prefix: --kmer-len
  - id: polishing_rounds
    type:
      - 'null'
      - int
    doc: number of times polishing is performed
    inputBinding:
      position: 102
      prefix: --polishing-rounds
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: window_len
    type:
      - 'null'
      - int
    doc: length of window used for error correction
    inputBinding:
      position: 102
      prefix: --window-len
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/raven-assembler:1.8.3--h5ca1c30_3
stdout: raven-assembler.out
