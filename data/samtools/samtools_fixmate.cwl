cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- fixmate
label: samtools_fixmate
doc: 'Fill in mate coordinates, ISIZE and mate related flags from a name-sorted alignment


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: input_file
  type: File
  doc: Input name-sorted (or name-grouped) SAM/BAM/CRAM file.
  inputBinding:
    position: 104
- id: output_filename
  type: string
  doc: Name of the output file.
  default: fixmate.bam
  inputBinding:
    position: 105
- id: remove_unmapped_and_secondary
  type:
  - 'null'
  - boolean
  doc: Remove unmapped reads and secondary alignments.
  inputBinding:
    position: 103
    prefix: -r
- id: disable_fr_pair_check
  type:
  - 'null'
  - boolean
  doc: Disable FR proper pair check.
  inputBinding:
    position: 103
    prefix: -p
- id: add_template_cigar
  type:
  - 'null'
  - boolean
  doc: Add template cigar ct tag.
  inputBinding:
    position: 103
    prefix: -c
- id: add_mate_score
  type:
  - 'null'
  - boolean
  doc: Add mate score tag.
  inputBinding:
    position: 103
    prefix: -m
- id: uncompressed
  type:
  - 'null'
  - boolean
  doc: Uncompressed output.
  inputBinding:
    position: 103
    prefix: -u
- id: sanitize
  type:
  - 'null'
  - string
  doc: Sanitize alignment fields as FLAG[,FLAG] [defaults to all types].
  inputBinding:
    position: 103
    prefix: --sanitize
- id: fix_base_modifications
  type:
  - 'null'
  - boolean
  doc: Fix base modification tags (MM/ML/MN).
  inputBinding:
    position: 103
    prefix: -M
- id: input_fmt_option
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --input-fmt-option
  doc: Specify a single input file format option in the form OPTION or OPTION=VALUE (repeatable).
  inputBinding:
    position: 103
- id: output_fmt
  type:
  - 'null'
  - string
  doc: Specify output format (SAM, BAM, CRAM) and optional format options, e.g. bam,level=1.
  inputBinding:
    position: 103
    prefix: --output-fmt
- id: output_fmt_option
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --output-fmt-option
  doc: Specify a single output file format option in the form OPTION or OPTION=VALUE (repeatable).
  inputBinding:
    position: 103
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence FASTA file (needed for CRAM).
  secondaryFiles:
  - pattern: .fai
    required: false
  inputBinding:
    position: 103
    prefix: --reference
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use.
  inputBinding:
    position: 103
    prefix: --threads
- id: no_pg
  type:
  - 'null'
  - boolean
  doc: Do not add a PG line to the header.
  inputBinding:
    position: 103
    prefix: --no-PG
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity.
  inputBinding:
    position: 103
    prefix: --verbosity
outputs:
- id: output
  type: File
  doc: Output file with fixed mate information.
  outputBinding:
    glob: $(inputs.output_filename)
