cwlVersion: v1.2
class: CommandLineTool
baseCommand: goleft
label: goleft_covstats
doc: "Estimate coverage statistics from BAM/CRAM files.\n\nTool homepage: https://github.com/brentp/goleft"
inputs:
  - id: bams
    type:
      type: array
      items: File
    doc: bams/crams for which to estimate coverage
    inputBinding:
      position: 1
  - id: fasta
    type:
      - 'null'
      - File
    doc: fasta file. required for cram format
    inputBinding:
      position: 102
      prefix: --fasta
  - id: num_reads_sample
    type:
      - 'null'
      - int
    doc: number of reads to sample for length
    default: 1000000
    inputBinding:
      position: 102
      prefix: --n
  - id: regions
    type:
      - 'null'
      - File
    doc: optional bed file to specify target regions
    inputBinding:
      position: 102
      prefix: --regions
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goleft:0.2.6--he881be0_1
stdout: goleft_covstats.out
