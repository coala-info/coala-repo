cwlVersion: v1.2
class: CommandLineTool
baseCommand: convert_bc_to_binary_RY.py
label: bctools_convert_bc_to_binary_RY.py
doc: "Convert standard nucleotides in FASTQ or FASTA format to IUPAC nucleotide codes
  used for binary RY-space barcodes.\nA and G are converted to R. T, U and C are converted
  to Y. By default output is written to stdout.\n\nTool homepage: https://github.com/dmaticzka/bctools"
inputs:
  - id: infile
    type: File
    doc: Path to fastq input file.
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print lots of debugging information
    inputBinding:
      position: 102
      prefix: --debug
  - id: fasta_format
    type:
      - 'null'
      - boolean
    doc: Read and write fasta instead of fastq format.
    inputBinding:
      position: 102
      prefix: --fasta-format
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Write results to this file.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bctools:0.2.2--pl5.22.0_0
