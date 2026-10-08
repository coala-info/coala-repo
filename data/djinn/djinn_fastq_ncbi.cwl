cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - djinn
  - fastq
  - ncbi
label: djinn_fastq_ncbi
doc: "FASTQ → BAM conversion for NCBI\n\nTool homepage: https://github.com/pdimens/djinn"
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 1
      prefix: --threads
  - id: input
    type:
      type: array
      items: File
    doc: 'Input FASTQ file(s): R1 and optional R2 (can be gzipped)'
    inputBinding:
      position: 101
outputs:
  - id: unaligned_bam
    type: stdout
    doc: Unaligned BAM with barcode tags
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
stdout: djinn_fastq_ncbi.bam
