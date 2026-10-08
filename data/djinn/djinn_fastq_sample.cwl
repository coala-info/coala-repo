cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - djinn
  - fastq
  - sample
label: djinn_fastq_sample
doc: "Downsample data by barcode\n\nTool homepage: https://github.com/pdimens/djinn"
inputs:
  - id: downsample
    type:
      - 'null'
      - float
    doc: Number/fraction of barcodes to retain
    inputBinding:
      position: 1
      prefix: --downsample
  - id: invalid
    type:
      - 'null'
      - float
    doc: Proportion of invalid barcodes to sample
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
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Random seed for sampling
    inputBinding:
      position: 1
      prefix: --random-seed
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
  - id: barcode_list
    type: File
    doc: Sampled barcodes (<prefix>.bc)
    outputBinding:
      glob: $(inputs.prefix).bc
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
