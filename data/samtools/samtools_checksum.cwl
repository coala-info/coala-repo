cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- checksum
label: samtools_checksum
doc: 'Produce order-agnostic checksums of sequence content


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: files
  type:
    type: array
    items: File
  doc: Input SAM/BAM/CRAM files (or checksum files with merge).
  inputBinding:
    position: 104
- id: exclude_flags
  type:
  - 'null'
  - string
  doc: Filter if any FLAGs are present [0x900].
  inputBinding:
    position: 103
    prefix: --exclude-flags
- id: require_flags
  type:
  - 'null'
  - string
  doc: Filter unless all FLAGs are present [0].
  inputBinding:
    position: 103
    prefix: --require-flags
- id: flag_mask
  type:
  - 'null'
  - string
  doc: BAM FLAGs to use in checksums [0x0c1].
  inputBinding:
    position: 103
    prefix: --flag-mask
- id: no_rev_comp
  type:
  - 'null'
  - boolean
  doc: Do not reverse-complement sequences.
  inputBinding:
    position: 103
    prefix: --no-rev-comp
- id: tags
  type:
  - 'null'
  - string
  doc: Select tags to checksum, STR[,STR] [BC,FI,QT,RT,TC].
  inputBinding:
    position: 103
    prefix: --tags
- id: in_order
  type:
  - 'null'
  - boolean
  doc: Use order-specific checksumming.
  inputBinding:
    position: 103
    prefix: --in-order
- id: check_pos
  type:
  - 'null'
  - boolean
  doc: Also checksum CHR / POS.
  inputBinding:
    position: 103
    prefix: --check-pos
- id: check_cigar
  type:
  - 'null'
  - boolean
  doc: Also checksum MAPQ / CIGAR.
  inputBinding:
    position: 103
    prefix: --check-cigar
- id: check_mate
  type:
  - 'null'
  - boolean
  doc: Also checksum PNEXT / RNEXT / TLEN.
  inputBinding:
    position: 103
    prefix: --check_mate
- id: sanitize
  type:
  - 'null'
  - string
  doc: Perform sanity checks and fix records.
  inputBinding:
    position: 103
    prefix: --sanitize
- id: count
  type:
  - 'null'
  - int
  doc: Stop after INT number of records [0].
  inputBinding:
    position: 103
    prefix: --count
- id: output_filename
  type: string
  doc: Write report to this file (-o).
  default: checksum.txt
  inputBinding:
    position: 103
    prefix: -o
- id: show_qc
  type:
  - 'null'
  - boolean
  doc: Also show QC pass/fail lines.
  inputBinding:
    position: 103
    prefix: --show-qc
- id: verbose
  type:
  - 'null'
  - boolean
  doc: 'Increase verbosity: show lines with 0 counts.'
  inputBinding:
    position: 103
    prefix: --verbose
- id: all
  type:
  - 'null'
  - boolean
  doc: 'Check all: -PCMOc -b 0xfff -f0 -F0 -z all,cigarx.'
  inputBinding:
    position: 103
    prefix: --all
- id: tabs
  type:
  - 'null'
  - boolean
  doc: Format output as tab delimited text.
  inputBinding:
    position: 103
    prefix: --tabs
- id: merge
  type:
  - 'null'
  - boolean
  doc: Merge checksum output files (the input files are earlier checksum reports).
  inputBinding:
    position: 103
    prefix: --merge
- id: bamseqchksum
  type:
  - 'null'
  - boolean
  doc: Report in bamseqchksum format.
  inputBinding:
    position: 103
    prefix: --bamseqchksum
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use [0].
  inputBinding:
    position: 103
    prefix: --threads
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
outputs:
- id: output
  type: File
  doc: Checksum report.
  outputBinding:
    glob: $(inputs.output_filename)
