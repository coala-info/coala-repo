cwlVersion: v1.2
class: CommandLineTool
baseCommand: cramtools cram
label: cramtools_cram
doc: "CRAM compression tool for converting BAM/SAM to CRAM\n\nTool homepage: https://github.com/enasequence/cramtools"
inputs:
  - id: capture_all_tags
    type:
      - 'null'
      - boolean
    doc: Capture all tags.
    default: false
    inputBinding:
      position: 101
      prefix: --capture-all-tags
  - id: capture_tags
    type:
      - 'null'
      - string
    doc: Capture the tags listed, for example 'OQ:XA:XB'
    default: ''
    inputBinding:
      position: 101
      prefix: --capture-tags
  - id: encrypt
    type:
      - 'null'
      - boolean
    doc: Encrypt the CRAM file.
    default: false
    inputBinding:
      position: 101
      prefix: --encrypt
  - id: ignore_md5_mismatch
    type:
      - 'null'
      - boolean
    doc: Fail on MD5 mismatch if true, or correct (overwrite) the checksums and continue
      if false.
    default: false
    inputBinding:
      position: 101
      prefix: --ignore-md5-mismatch
  - id: ignore_tags
    type:
      - 'null'
      - string
    doc: Ignore the tags listed, for example 'OQ:XA:XB'
    default: ''
    inputBinding:
      position: 101
      prefix: --ignore-tags
  - id: inject_sq_uri
    type:
      - 'null'
      - boolean
    doc: Inject or change the @SQ:UR header fields to point to ENA reference service.
    default: false
    inputBinding:
      position: 101
      prefix: --inject-sq-uri
  - id: input_bam_file
    type:
      - 'null'
      - File
    doc: Path to a BAM file to be converted to CRAM. Omit if standard input (pipe).
    inputBinding:
      position: 101
      prefix: --input-bam-file
  - id: input_is_sam
    type:
      - 'null'
      - boolean
    doc: Input is in SAM format.
    default: false
    inputBinding:
      position: 101
      prefix: --input-is-sam
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Change log level: DEBUG, INFO, WARNING, ERROR.'
    default: ERROR
    inputBinding:
      position: 101
      prefix: --log-level
  - id: lossless_quality_score
    type:
      - 'null'
      - boolean
    doc: Preserve all quality scores. Overwrites '--lossless-quality-score'.
    default: false
    inputBinding:
      position: 101
      prefix: --lossless-quality-score
  - id: lossy_quality_score_spec
    type:
      - 'null'
      - string
    doc: A string specifying what quality scores should be preserved.
    default: ''
    inputBinding:
      position: 101
      prefix: --lossy-quality-score-spec
  - id: max_records
    type:
      - 'null'
      - int
    doc: Stop after compressing this many records.
    default: 9223372036854775807
    inputBinding:
      position: 101
      prefix: --max-records
  - id: preserve_read_names
    type:
      - 'null'
      - boolean
    doc: Preserve all read names.
    default: false
    inputBinding:
      position: 101
      prefix: --preserve-read-names
  - id: reference_fasta_file
    type:
      - 'null'
      - File
    doc: The reference fasta file, uncompressed and indexed (.fai file, use 'samtools
      faidx').
    inputBinding:
      position: 101
      prefix: --reference-fasta-file
outputs:
  - id: output_cram_file
    type:
      - 'null'
      - File
    doc: The path for the output CRAM file. Omit if standard output (pipe).
    outputBinding:
      glob: $(inputs.output_cram_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cramtools:3.0.b127--0
