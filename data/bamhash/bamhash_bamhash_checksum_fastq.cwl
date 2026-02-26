cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamhash_checksum_fastq
label: bamhash_bamhash_checksum_fastq
doc: "Program for checksum of sequence reads.\n\nTool homepage: https://github.com/DecodeGenetics/BamHash"
inputs:
  - id: input_fastq_files
    type:
      type: array
      items: File
    doc: Input fastq.gz files
    inputBinding:
      position: 1
  - id: debug_mode
    type:
      - 'null'
      - boolean
    doc: Debug mode. Prints full hex for each read to stdout
    inputBinding:
      position: 102
      prefix: --debug
  - id: no_paired
    type:
      - 'null'
      - boolean
    doc: List of fastq files are not paired-end reads
    inputBinding:
      position: 102
      prefix: --no-paired
  - id: no_quality
    type:
      - 'null'
      - boolean
    doc: Do not use read quality as part of checksum
    inputBinding:
      position: 102
      prefix: --no-quality
  - id: no_readnames
    type:
      - 'null'
      - boolean
    doc: Do not use read names as part of checksum
    inputBinding:
      position: 102
      prefix: --no-readnames
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamhash:2.0--h35c04b2_0
stdout: bamhash_bamhash_checksum_fastq.out
