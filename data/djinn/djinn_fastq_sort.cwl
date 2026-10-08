cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - djinn
  - fastq
  - sort
label: djinn_fastq_sort
doc: "Sort by barcode\n\nTool homepage: https://github.com/pdimens/djinn"
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (minimum 6)
    inputBinding:
      position: 1
      prefix: --threads
  - id: sam_tag
    type: string
    doc: SAM tag that holds the barcode (e.g. BX, BC)
    inputBinding:
      position: 101
  - id: prefix
    type: string
    doc: Output file name prefix
    inputBinding:
      position: 102
  - id: input
    type:
      type: array
      items: File
    doc: 'Input FASTQ file(s): R1 and optional R2 (can be gzipped)'
    inputBinding:
      position: 103
outputs:
  - id: r1_fastq
    type: File
    doc: Output R1 FASTQ (<prefix>.R1.fq.gz)
    outputBinding:
      glob: $(inputs.prefix).R1.fq.gz
  - id: r2_fastq
    type: File?
    doc: Output R2 FASTQ (<prefix>.R2.fq.gz), for paired-end input
    outputBinding:
      glob: $(inputs.prefix).R2.fq.gz
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
