cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - calmd
label: samtools_calmd
doc: "Generate the MD tag and optionally compute BAQ (Base Alignment Quality)\n\n\
  Tool homepage: https://github.com/samtools/samtools"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: reference_fasta
    type: File
    doc: Reference sequence FASTA file
    inputBinding:
      position: 2
  - id: change_identical
    type:
      - 'null'
      - boolean
    doc: change identical bases to '='
    inputBinding:
      position: 103
      prefix: -e
  - id: compressed_bam
    type:
      - 'null'
      - boolean
    doc: compressed BAM output
    inputBinding:
      position: 103
      prefix: -b
  - id: compute_bq_baq
    type:
      - 'null'
      - boolean
    doc: compute the BQ tag (without -A) or cap baseQ by BAQ (with -A)
    inputBinding:
      position: 103
      prefix: -r
  - id: extended_baq
    type:
      - 'null'
      - boolean
    doc: extended BAQ for better sensitivity but lower specificity
    inputBinding:
      position: 103
      prefix: -E
  - id: ignored_input_format
    type:
      - 'null'
      - boolean
    doc: ignored (input format is auto-detected)
    inputBinding:
      position: 103
      prefix: -S
  - id: input_fmt_option
    type:
      - 'null'
      - string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 103
      prefix: --input-fmt-option
  - id: modify_quality
    type:
      - 'null'
      - boolean
    doc: modify the quality string
    inputBinding:
      position: 103
      prefix: -A
  - id: no_pg
    type:
      - 'null'
      - boolean
    doc: do not add a PG line
    inputBinding:
      position: 103
      prefix: --no-PG
  - id: output_fmt
    type:
      - 'null'
      - string
    doc: Specify output format (SAM, BAM, CRAM)
    inputBinding:
      position: 103
      prefix: --output-fmt
  - id: output_fmt_option
    type:
      - 'null'
      - string
    doc: Specify a single output file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 103
      prefix: --output-fmt-option
  - id: quiet_mode
    type:
      - 'null'
      - boolean
    doc: use quiet mode to output less debug info to stdout
    inputBinding:
      position: 103
      prefix: -Q
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE [null]
    inputBinding:
      position: 103
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use
    default: 0
    inputBinding:
      position: 103
      prefix: --threads
  - id: uncompressed_bam
    type:
      - 'null'
      - boolean
    doc: uncompressed BAM output (for piping)
    inputBinding:
      position: 103
      prefix: -u
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set level of verbosity
    inputBinding:
      position: 103
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
stdout: samtools_calmd.out
