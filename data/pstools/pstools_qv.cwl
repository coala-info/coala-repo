cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pstools
  - qv
label: pstools_qv
doc: "Calculate QV (Quality Value) using Hi-C data and a sequence file\n\nTool homepage:
  https://github.com/shilpagarg/pstools"
inputs:
  - id: sequence_file
    type: File
    doc: Input sequence file (fasta)
    inputBinding:
      position: 1
  - id: hic_r1
    type: File
    doc: Hi-C R1 fastq file (gzipped)
    inputBinding:
      position: 2
  - id: hic_r2
    type: File
    doc: Hi-C R2 fastq file (gzipped)
    inputBinding:
      position: 3
  - id: chunk_size
    type:
      - 'null'
      - string
    doc: chunk size
    default: 100m
    inputBinding:
      position: 104
      prefix: -K
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size
    default: 31
    inputBinding:
      position: 104
      prefix: -k
  - id: threads
    type:
      - 'null'
      - int
    doc: number of worker threads
    default: 4
    inputBinding:
      position: 104
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pstools:0.2a3--h077b44d_4
stdout: pstools_qv.out
