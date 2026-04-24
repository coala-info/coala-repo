cwlVersion: v1.2
class: CommandLineTool
baseCommand: cramtools bam
label: cramtools_bam
doc: "A tool to process CRAM files, including conversion to BAM, decryption, and tag
  calculation.\n\nTool homepage: https://github.com/enasequence/cramtools"
inputs:
  - id: region
    type:
      - 'null'
      - string
    doc: A region to access specified as <sequence name>[:<start inclusive>[-[<stop
      inclusive>]]
    inputBinding:
      position: 1
  - id: calculate_md_tag
    type:
      - 'null'
      - boolean
    doc: Calculate MD tag.
    inputBinding:
      position: 102
      prefix: --calculate-md-tag
  - id: calculate_nm_tag
    type:
      - 'null'
      - boolean
    doc: Calculate NM tag.
    inputBinding:
      position: 102
      prefix: --calculate-nm-tag
  - id: count_only
    type:
      - 'null'
      - boolean
    doc: Count number of records.
    inputBinding:
      position: 102
      prefix: --count-only
  - id: decrypt
    type:
      - 'null'
      - boolean
    doc: Decrypt the file.
    inputBinding:
      position: 102
      prefix: --decrypt
  - id: default_quality_score
    type:
      - 'null'
      - int
    doc: Use this quality score (decimal representation of ASCII symbol) as a default
      value when the original quality score was lost due to compression. Minimum is
      33.
    inputBinding:
      position: 102
      prefix: --default-quality-score
  - id: filter_flags
    type:
      - 'null'
      - int
    doc: Filtering flags.
    inputBinding:
      position: 102
      prefix: --filter-flags
  - id: header_only
    type:
      - 'null'
      - boolean
    doc: Print SAM header and quit.
    inputBinding:
      position: 102
      prefix: -H
  - id: ignore_md5_mismatch
    type:
      - 'null'
      - boolean
    doc: Issue a warning on sequence MD5 mismatch and continue. This does not garantee
      the data will be read succesfully.
    inputBinding:
      position: 102
      prefix: --ignore-md5-mismatch
  - id: inject_sq_uri
    type:
      - 'null'
      - boolean
    doc: Inject or change the @SQ:UR header fields to point to ENA reference service.
    inputBinding:
      position: 102
      prefix: --inject-sq-uri
  - id: input_cram_file
    type:
      - 'null'
      - File
    doc: The path or FTP URL to the CRAM file to uncompress. Omit if standard input
      (pipe).
    inputBinding:
      position: 102
      prefix: --input-cram-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Change log level: DEBUG, INFO, WARNING, ERROR.'
    inputBinding:
      position: 102
      prefix: --log-level
  - id: output_bam_format
    type:
      - 'null'
      - boolean
    doc: Output in BAM format.
    inputBinding:
      position: 102
      prefix: --output-bam-format
  - id: password
    type:
      - 'null'
      - string
    doc: Password to decrypt the file.
    inputBinding:
      position: 102
      prefix: --password
  - id: print_sam_header
    type:
      - 'null'
      - boolean
    doc: Print SAM header when writing SAM format.
    inputBinding:
      position: 102
      prefix: --print-sam-header
  - id: reference_fasta_file
    type:
      - 'null'
      - File
    doc: Path to the reference fasta file, it must be uncompressed and indexed (use
      'samtools faidx' for example).
    inputBinding:
      position: 102
      prefix: --reference-fasta-file
  - id: required_flags
    type:
      - 'null'
      - int
    doc: Required flags.
    inputBinding:
      position: 102
      prefix: --required-flags
  - id: skip_md5_check
    type:
      - 'null'
      - boolean
    doc: Skip MD5 checks when reading the header.
    inputBinding:
      position: 102
      prefix: --skip-md5-check
  - id: sync_bam_output
    type:
      - 'null'
      - boolean
    doc: Write BAM output in the same thread.
    inputBinding:
      position: 102
      prefix: --sync-bam-output
outputs:
  - id: output_bam_file
    type:
      - 'null'
      - File
    doc: The path to the output BAM file.
    outputBinding:
      glob: $(inputs.output_bam_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cramtools:3.0.b127--0
