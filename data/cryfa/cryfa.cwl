cwlVersion: v1.2
class: CommandLineTool
baseCommand: cryfa
label: cryfa
doc: "A secure encryption tool for genomic data. Compacts and encrypts FASTA/FASTQ
  files, or encrypts any text-based genomic data like VCF/SAM/BAM.\n\nTool homepage:
  https://github.com/smortezah/cryfa"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file to be encrypted or decrypted.
    inputBinding:
      position: 1
  - id: decrypt
    type:
      - 'null'
      - boolean
    doc: Decrypt and unpack the input file.
    inputBinding:
      position: 102
      prefix: --dec
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force Cryfa to consider input as non-FASTA/FASTQ. Compaction will be ignored,
      but shuffling and encryption will be performed.
    inputBinding:
      position: 102
      prefix: --force
  - id: key_file
    type: File
    doc: Key file name containing a password. Mandatory.
    inputBinding:
      position: 102
      prefix: --key
  - id: stop_shuffle
    type:
      - 'null'
      - boolean
    doc: Stop shuffling the input.
    inputBinding:
      position: 102
      prefix: --stop_shuffle
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 102
      prefix: --thread
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode (provides more information).
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cryfa:20.04--h9948957_3
stdout: cryfa.out
