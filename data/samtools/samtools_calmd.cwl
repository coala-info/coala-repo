cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- calmd
label: samtools_calmd
doc: 'Calculate MD and NM tags


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: aln_bam
  type: File
  doc: Input alignment file.
  inputBinding:
    position: 104
- id: ref_fasta
  type: File
  doc: Reference FASTA file.
  secondaryFiles:
  - pattern: .fai
    required: false
  inputBinding:
    position: 105
- id: change_identical_bases
  type:
  - 'null'
  - boolean
  doc: Change identical bases to '='.
  inputBinding:
    position: 103
    prefix: -e
- id: uncompressed_bam
  type:
  - 'null'
  - boolean
  doc: Uncompressed BAM output (for piping).
  inputBinding:
    position: 103
    prefix: -u
- id: compressed_bam
  type:
  - 'null'
  - boolean
  doc: Compressed BAM output.
  inputBinding:
    position: 103
    prefix: -b
- id: modify_quality
  type:
  - 'null'
  - boolean
  doc: Modify the quality string.
  inputBinding:
    position: 103
    prefix: -A
- id: quiet
  type:
  - 'null'
  - boolean
  doc: Use quiet mode to output less debug info.
  inputBinding:
    position: 103
    prefix: -Q
- id: compute_bq
  type:
  - 'null'
  - boolean
  doc: Compute the BQ tag (without -A) or cap baseQ by BAQ (with -A).
  inputBinding:
    position: 103
    prefix: -r
- id: extended_baq
  type:
  - 'null'
  - boolean
  doc: Extended BAQ for better sensitivity but lower specificity.
  inputBinding:
    position: 103
    prefix: -E
- id: no_pg
  type:
  - 'null'
  - boolean
  doc: Do not add a PG line.
  inputBinding:
    position: 103
    prefix: --no-PG
- id: output_fmt
  type:
  - 'null'
  - string
  doc: Output format FORMAT[,OPT[=VAL]]... (SAM, BAM, CRAM).
  inputBinding:
    position: 103
    prefix: --output-fmt
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use [0].
  inputBinding:
    position: 103
    prefix: --threads
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity.
  inputBinding:
    position: 103
    prefix: --verbosity
- id: output_filename
  type: string
  doc: Name of the file that receives standard output (SAM, or BAM with -b/-u).
  default: calmd.sam
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
  doc: Reference sequence FASTA file.
  secondaryFiles:
  - pattern: .fai
    required: false
  inputBinding:
    position: 103
    prefix: --reference
outputs:
- id: output
  type: File
  doc: Alignment file with recalculated MD/NM tags.
  outputBinding:
    glob: $(inputs.output_filename)
stdout: $(inputs.output_filename)
