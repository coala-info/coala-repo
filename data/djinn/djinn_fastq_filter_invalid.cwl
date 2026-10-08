cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - djinn
  - fastq
  - filter-invalid
label: djinn_fastq_filter_invalid
doc: "Retain only valid-barcoded reads\n\nTool homepage: https://github.com/pdimens/djinn"
inputs:
  - id: invalid
    type:
      - 'null'
      - boolean
    doc: Separately output records with invalid barcodes
    inputBinding:
      position: 1
      prefix: --invalid
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of compression threads to use for output files
    inputBinding:
      position: 1
      prefix: --threads
  - id: prefix
    type: string
    doc: Output file name prefix
    inputBinding:
      position: 101
  - id: input
    type:
      type: array
      items: File
    doc: 'Input FASTQ file(s): R1 and optional R2 (can be gzipped)'
    inputBinding:
      position: 102
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
  - id: invalid_fastq
    type:
      type: array
      items: File
    doc: Records with invalid barcodes (<prefix>.invalid.R*.fq.gz), with --invalid
    outputBinding:
      glob: $(inputs.prefix).invalid.R*.fq.gz
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
