cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - fixmate
label: samtools_fixmate
doc: "Fill in mate coordinates, ISIZE and mate related flags from a name-sorted alignment
  file.\n\nTool homepage: https://github.com/samtools/samtools"
inputs:
  - id: input_bam
    type: File
    doc: Input name-sorted BAM file
    inputBinding:
      position: 1
  - id: add_cigar_ct
    type:
      - 'null'
      - boolean
    doc: Add template cigar ct tag
    inputBinding:
      position: 102
      prefix: -c
  - id: add_mate_score
    type:
      - 'null'
      - boolean
    doc: Add mate score tag
    inputBinding:
      position: 102
      prefix: -m
  - id: disable_fr_check
    type:
      - 'null'
      - boolean
    doc: Disable FR proper pair check
    inputBinding:
      position: 102
      prefix: -p
  - id: fix_base_mod_tags
    type:
      - 'null'
      - boolean
    doc: Fix base modification tags (MM/ML/MN)
    inputBinding:
      position: 102
      prefix: -M
  - id: input_fmt_option
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --input-fmt-option
  - id: no_pg
    type:
      - 'null'
      - boolean
    doc: do not add a PG line
    inputBinding:
      position: 102
      prefix: --no-PG
  - id: output_fmt
    type:
      - 'null'
      - string
    doc: Specify output format (SAM, BAM, CRAM)
    inputBinding:
      position: 102
      prefix: --output-fmt
  - id: output_fmt_option
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify a single output file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --output-fmt-option
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE [null]
    inputBinding:
      position: 102
      prefix: --reference
  - id: remove_unmapped
    type:
      - 'null'
      - boolean
    doc: Remove unmapped reads and secondary alignments
    inputBinding:
      position: 102
      prefix: -r
  - id: sanitize
    type:
      - 'null'
      - string
    doc: Sanitize alignment fields [defaults to all types]
    inputBinding:
      position: 102
      prefix: --sanitize
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: uncompressed_output
    type:
      - 'null'
      - boolean
    doc: Uncompressed output
    inputBinding:
      position: 102
      prefix: -u
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set level of verbosity
    inputBinding:
      position: 102
      prefix: --verbosity
outputs:
  - id: output_bam
    type: File
    doc: Output name-sorted BAM file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
