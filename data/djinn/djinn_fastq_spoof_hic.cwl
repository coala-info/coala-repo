cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - djinn
  - fastq
  - spoof-hic
label: djinn_fastq_spoof_hic
doc: "Convert linked-reads into fake HI-C data\n\nTool homepage: https://github.com/pdimens/djinn"
inputs:
  - id: invalid
    type:
      - 'null'
      - boolean
    doc: Include invalid barcodes in the output
    inputBinding:
      position: 1
      prefix: --invalid
  - id: singletons
    type:
      - 'null'
      - boolean
    doc: Include singleton barcodes in the output
    inputBinding:
      position: 1
      prefix: --singletons
  - id: max_pairs
    type:
      - 'null'
      - int
    doc: Maximum number of R2 reads per R1 per barcode
    inputBinding:
      position: 1
      prefix: --max-pairs
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
  - id: inputs
    type:
      type: array
      items: File
    doc: Input FASTQ pair (R1 and R2), sorted by barcode and properly paired
    inputBinding:
      position: 102
outputs:
  - id: r1_fastq
    type: File
    doc: Output R1 FASTQ (<prefix>.R1.fq.gz)
    outputBinding:
      glob: $(inputs.prefix).R1.fq.gz
  - id: r2_fastq
    type: File
    doc: Output R2 FASTQ (<prefix>.R2.fq.gz)
    outputBinding:
      glob: $(inputs.prefix).R2.fq.gz
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
