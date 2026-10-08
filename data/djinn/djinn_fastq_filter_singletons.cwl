cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - djinn
  - fastq
  - filter-singletons
label: djinn_fastq_filter_singletons
doc: "Retain reads with non-singleton barcodes\n\nTool homepage: https://github.com/pdimens/djinn"
inputs:
  - id: singletons
    type:
      - 'null'
      - boolean
    doc: Separately output records with valid singleton barcodes
    inputBinding:
      position: 1
      prefix: --singletons
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
  - id: singleton_fastq
    type:
      type: array
      items: File
    doc: Records with singleton barcodes (<prefix>.singletons.R*.fq.gz), with --singletons
    outputBinding:
      glob: $(inputs.prefix).singletons.R*.fq.gz
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
