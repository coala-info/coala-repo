cwlVersion: v1.2
class: CommandLineTool
baseCommand: cramtools fastq
label: cramtools_fastq
doc: "Uncompress CRAM files into FASTQ format.\n\nTool homepage: https://github.com/enasequence/cramtools"
inputs:
  - id: default_quality_score
    type:
      - 'null'
      - int
    doc: Use this quality score (decimal representation of ASCII symbol) as a default
      value when the original quality score was lost due to compression. Minimum is
      33.
    inputBinding:
      position: 101
      prefix: --default-quality-score
  - id: enumerate
    type:
      - 'null'
      - boolean
    doc: Append read names with read index (/1 for first in pair, /2 for second in
      pair).
    inputBinding:
      position: 101
      prefix: --enumerate
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Compress fastq files with gzip.
    inputBinding:
      position: 101
      prefix: --gzip
  - id: ignore_md5_mismatch
    type:
      - 'null'
      - boolean
    doc: Issue a warning on sequence MD5 mismatch and continue. This does not garantee
      the data will be read succesfully.
    inputBinding:
      position: 101
      prefix: --ignore-md5-mismatch
  - id: input_cram_file
    type:
      - 'null'
      - File
    doc: The path to the CRAM file to uncompress. Omit if standard input (pipe).
    inputBinding:
      position: 101
      prefix: --input-cram-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Change log level: DEBUG, INFO, WARNING, ERROR.'
    inputBinding:
      position: 101
      prefix: --log-level
  - id: max_records
    type:
      - 'null'
      - int
    doc: Stop after reading this many records.
    inputBinding:
      position: 101
      prefix: --max-records
  - id: read_name_prefix
    type:
      - 'null'
      - string
    doc: Replace read names with this prefix and a sequential integer.
    inputBinding:
      position: 101
      prefix: --read-name-prefix
  - id: reference_fasta_file
    type:
      - 'null'
      - File
    doc: Path to the reference fasta file, it must be uncompressed and indexed (use
      'samtools faidx' for example).
    inputBinding:
      position: 101
      prefix: --reference-fasta-file
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Re-reverse reads mapped to negative strand.
    inputBinding:
      position: 101
      prefix: --reverse
  - id: skip_md5_check
    type:
      - 'null'
      - boolean
    doc: Skip MD5 checks when reading the header.
    inputBinding:
      position: 101
      prefix: --skip-md5-check
outputs:
  - id: fastq_base_name
    type:
      - 'null'
      - File
    doc: "'_number.fastq[.gz] will be appended to this string to obtain output fastq
      file name. If this parameter is omitted then all reads are printed with no garanteed
      order."
    outputBinding:
      glob: $(inputs.fastq_base_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cramtools:3.0.b127--0
