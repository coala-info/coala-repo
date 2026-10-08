cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - djinn
  - fastq
  - standardize
label: djinn_fastq_standardize
doc: "Move barcodes to BX+VX sequence header tags\n\nTool homepage: https://github.com/pdimens/djinn"
inputs:
  - id: style
    type:
      - 'null'
      - type: enum
        symbols:
          - haplotagging
          - stlfr
          - tellseq
          - 10x
    doc: Change the barcode style
    inputBinding:
      position: 1
      prefix: --style
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
  - id: barcode_map
    type: File?
    doc: Barcode conversion map (<prefix>.bc), with --style
    outputBinding:
      glob: $(inputs.prefix).bc
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
