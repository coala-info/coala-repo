cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - djinn
  - fastq
  - convert
label: djinn_fastq_convert
doc: "Convert between linked-read formats\n\nTool homepage: https://github.com/pdimens/djinn"
inputs:
  - id: barcodes
    type:
      - 'null'
      - File
    doc: barcodes file [10x input only]
    inputBinding:
      position: 1
      prefix: --barcodes
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
  - id: target
    type:
      type: enum
      symbols:
        - 10x
        - haplotagging
        - stlfr
        - tellseq
    doc: Target linked-read barcode format
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
  - id: barcode_map
    type: File
    doc: Barcode conversion map (<prefix>.bc)
    outputBinding:
      glob: $(inputs.prefix).bc
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
