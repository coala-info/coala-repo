cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - fixmate
label: samtools_fixmate
doc: Fix mate information on name-sorted SAM/BAM/CRAM files
inputs:
  - id: in_bam
    type: File
    doc: Input name-sorted BAM/SAM/CRAM file
    inputBinding:
      position: 1
  - id: out_bam
    type: string
    doc: Output name-sorted BAM/SAM/CRAM file
    inputBinding:
      position: 2
  - id: remove_unmapped_and_secondary
    type:
      - 'null'
      - boolean
    doc: Remove unmapped reads and secondary alignments
    inputBinding:
      position: 103
      prefix: -r
  - id: disable_fr_pair_check
    type:
      - 'null'
      - boolean
    doc: Disable FR proper pair check
    inputBinding:
      position: 103
      prefix: -p
  - id: add_template_cigar
    type:
      - 'null'
      - boolean
    doc: Add template cigar ct tag
    inputBinding:
      position: 103
      prefix: -c
  - id: add_mate_score
    type:
      - 'null'
      - boolean
    doc: Add mate score tag
    inputBinding:
      position: 103
      prefix: -m
  - id: uncompressed_output
    type:
      - 'null'
      - boolean
    doc: Uncompressed output
    inputBinding:
      position: 103
      prefix: -u
  - id: sanitize
    type:
      - 'null'
      - type: array
        items: string
    doc: Sanitize alignment fields [defaults to all types]
    inputBinding:
      position: 103
      prefix: --sanitize
      itemSeparator: ','
  - id: fix_base_modifications
    type:
      - 'null'
      - boolean
    doc: Fix base modification tags (MM/ML/MN)
    inputBinding:
      position: 103
      prefix: -M
  - id: no_pg
    type:
      - 'null'
      - boolean
    doc: do not add a PG line
    inputBinding:
      position: 103
      prefix: --no-PG
  - id: input_fmt_option
    type:
      - 'null'
      - string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 103
      prefix: --input-fmt-option
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
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE [null]
    secondaryFiles:
      - .fai
    inputBinding:
      position: 103
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use [0]
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: out_out_bam
    type: File
    doc: Output name-sorted BAM/SAM/CRAM file
    outputBinding:
      glob: $(inputs.out_bam)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
