cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pstools
  - phasing_error
label: pstools_phasing_error
doc: "Calculate phasing errors using haplotype assemblies and Hi-C data\n\nTool homepage:
  https://github.com/shilpagarg/pstools"
inputs:
  - id: hap1_fa
    type: File
    doc: Haplotype 1 assembly file (fasta)
    inputBinding:
      position: 1
  - id: hap2_fa
    type: File
    doc: Haplotype 2 assembly file (fasta)
    inputBinding:
      position: 2
  - id: hic_r1_fastq
    type: File
    doc: Hi-C read 1 fastq file (gzipped)
    inputBinding:
      position: 3
  - id: hic_r2_fastq
    type: File
    doc: Hi-C read 2 fastq file (gzipped)
    inputBinding:
      position: 4
  - id: chunk_size
    type:
      - 'null'
      - string
    doc: chunk size
    default: 100m
    inputBinding:
      position: 105
      prefix: -K
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size
    default: 31
    inputBinding:
      position: 105
      prefix: -k
  - id: threads
    type:
      - 'null'
      - int
    doc: number of worker threads
    default: 4
    inputBinding:
      position: 105
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pstools:0.2a3--h077b44d_4
stdout: pstools_phasing_error.out
