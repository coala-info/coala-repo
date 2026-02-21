cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biscuit
  - bc
label: biscuit_bc
doc: "Extract barcodes from FASTQ files and append to read names. Adds an artificial
  UMI (AAAAAAAA) for compatibility.\n\nTool homepage: https://github.com/huishenlab/biscuit"
inputs:
  - id: fastq_1
    type: File
    doc: Input FASTQ file 1
    inputBinding:
      position: 1
  - id: fastq_2
    type:
      - 'null'
      - File
    doc: Input FASTQ file 2
    inputBinding:
      position: 2
  - id: bc_length
    type:
      - 'null'
      - int
    doc: length of barcode
    default: 8
    inputBinding:
      position: 103
      prefix: --bc-length
  - id: bc_start
    type:
      - 'null'
      - int
    doc: start position of barcode in read (1-based)
    default: 1
    inputBinding:
      position: 103
      prefix: --bc-start
  - id: mate
    type:
      - 'null'
      - int
    doc: which mate the barcode is in (1 or 2)
    default: 1
    inputBinding:
      position: 103
      prefix: --mate
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: prefix for output files (NULL writes to stdout)
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biscuit:1.7.1.20250908--hc4b60c0_0
