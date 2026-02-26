cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract_bcs.py
label: bctools_extract_bcs.py
doc: "Exract barcodes from a FASTQ file according to a user-specified pattern. Starting
  from the 5'-end, positions marked by X will be moved into a separate FASTQ file.
  Positions marked bv N will be kept.\n\nTool homepage: https://github.com/dmaticzka/bctools"
inputs:
  - id: infile
    type: File
    doc: Path to fastq file.
    inputBinding:
      position: 1
  - id: pattern
    type: string
    doc: "Pattern of barcode nucleotides starting at 5'-end. X\n                 \
      \       positions will be moved to the header, N positions\n               \
      \         will be kept."
    inputBinding:
      position: 2
  - id: add_bc_to_fastq
    type:
      - 'null'
      - boolean
    doc: Append extracted barcodes to the FASTQ headers.
    inputBinding:
      position: 103
      prefix: --add-bc-to-fastq
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print lots of debugging information
    inputBinding:
      position: 103
      prefix: --debug
  - id: fasta_barcodes
    type:
      - 'null'
      - boolean
    doc: Save extracted barcodes in FASTA format.
    inputBinding:
      position: 103
      prefix: --fasta-barcodes
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Write results to this file.
    outputBinding:
      glob: $(inputs.outfile)
  - id: out_bc_fasta
    type:
      - 'null'
      - File
    doc: Write barcodes to this file in FASTQ format.
    outputBinding:
      glob: $(inputs.out_bc_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bctools:0.2.2--pl5.22.0_0
