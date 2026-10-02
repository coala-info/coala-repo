cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - calmd
label: samtools_calmd
doc: Generate the MD tag and calculate base alignment quality (BAQ)
inputs:
  - id: aln_bam
    type: File
    doc: Input alignment BAM/SAM/CRAM file
    inputBinding:
      position: 1
  - id: ref_fasta
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA file
    secondaryFiles:
      - .fai
    inputBinding:
      position: 2
  - id: change_identical_bases
    type:
      - 'null'
      - boolean
    doc: change identical bases to '='
    inputBinding:
      position: 103
      prefix: -e
  - id: uncompressed_bam
    type:
      - 'null'
      - boolean
    doc: uncompressed BAM output (for piping)
    inputBinding:
      position: 103
      prefix: -u
  - id: compressed_bam
    type:
      - 'null'
      - boolean
    doc: compressed BAM output
    inputBinding:
      position: 103
      prefix: -b
  - id: ignored_input_format
    type:
      - 'null'
      - boolean
    doc: ignored (input format is auto-detected)
    inputBinding:
      position: 103
      prefix: -S
  - id: modify_quality
    type:
      - 'null'
      - boolean
    doc: modify the quality string
    inputBinding:
      position: 103
      prefix: -A
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: use quiet mode to output less debug info to stdout
    inputBinding:
      position: 103
      prefix: -Q
  - id: compute_bq
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
    doc: Number of additional threads to use
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
stdout: samtools_calmd.out
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
