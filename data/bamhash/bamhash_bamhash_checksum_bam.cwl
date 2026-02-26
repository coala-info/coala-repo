cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamhash_checksum_bam
label: bamhash_bamhash_checksum_bam
doc: "Checksum of a sam, bam or cram file\n\nTool homepage: https://github.com/DecodeGenetics/BamHash"
inputs:
  - id: input_bams
    type:
      type: array
      items: File
    doc: Input BAM files
    inputBinding:
      position: 1
  - id: debug
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
    doc: Cram files were not generated with paired-end reads
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
  - id: reference_file
    type:
      - 'null'
      - File
    doc: 'Path to reference-file if reference not given in header Valid filetype is:
      fa.'
    inputBinding:
      position: 102
      prefix: --reference-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamhash:2.0--h35c04b2_0
stdout: bamhash_bamhash_checksum_bam.out
