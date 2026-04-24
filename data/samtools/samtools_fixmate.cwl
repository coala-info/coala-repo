cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- fixmate
label: samtools_fixmate
doc: |-
  Fill in mate coordinates, ISIZE and mate related flags from a name-sorted alignment file.

  Tool homepage: https://github.com/samtools/samtools
requirements:
- class: InlineJavascriptRequirement
inputs:
- id: input_bam
  type: File
  doc: Input name-sorted BAM file
  inputBinding:
    position: 50
- id: add_cigar_ct
  type: boolean?
  doc: Add template cigar ct tag
  inputBinding:
    position: 1
    prefix: -c
- id: add_mate_score
  type: boolean?
  doc: Add mate score tag
  inputBinding:
    position: 1
    prefix: -m
- id: disable_fr_check
  type: boolean?
  doc: Disable FR proper pair check
  inputBinding:
    position: 1
    prefix: -p
- id: fix_base_mod_tags
  type: boolean?
  doc: Fix base modification tags (MM/ML/MN)
  inputBinding:
    position: 1
    prefix: -M
- id: input_fmt_option
  type: string[]?
  doc: Specify a single input file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 1
    prefix: --input-fmt-option
- id: no_pg
  type: boolean?
  doc: do not add a PG line
  inputBinding:
    position: 1
    prefix: --no-PG
- id: output_fmt
  type: string?
  doc: Specify output format (SAM, BAM, CRAM)
  inputBinding:
    position: 1
    prefix: --output-fmt
- id: output_fmt_option
  type: string[]?
  doc: Specify a single output file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 1
    prefix: --output-fmt-option
- id: reference
  type: File?
  doc: Reference sequence FASTA FILE [null]
  inputBinding:
    position: 1
    prefix: --reference
- id: remove_unmapped
  type: boolean?
  doc: Remove unmapped reads and secondary alignments
  inputBinding:
    position: 1
    prefix: -r
- id: sanitize
  type: string?
  doc: Sanitize alignment fields [defaults to all types]
  inputBinding:
    position: 1
    prefix: --sanitize
- id: threads
  type: int?
  doc: Number of additional threads to use
  inputBinding:
    position: 1
    prefix: --threads
- id: uncompressed_output
  type: boolean?
  doc: Uncompressed output
  inputBinding:
    position: 1
    prefix: -u
- id: verbosity
  type: int?
  doc: Set level of verbosity
  inputBinding:
    position: 1
    prefix: --verbosity
arguments:
- position: 1
  prefix: -n
- position: 51
  valueFrom: $(inputs.input_bam.nameroot).fixmate.bam
outputs:
- id: output_bam
  type: File
  doc: Output name-sorted BAM file
  outputBinding:
    glob: $(inputs.input_bam.nameroot).fixmate.bam
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
