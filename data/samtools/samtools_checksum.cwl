cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - checksum
label: samtools_checksum
doc: Generate or merge checksums for SAM/BAM/CRAM files
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input BAM files or checksum files
    inputBinding:
      position: 1
  - id: exclude_flags
    type:
      - 'null'
      - string
    doc: Filter if any FLAGs are present
    inputBinding:
      position: 102
      prefix: --exclude-flags
  - id: require_flags
    type:
      - 'null'
      - string
    doc: Filter unless all FLAGs are present
    inputBinding:
      position: 102
      prefix: --require-flags
  - id: flag_mask
    type:
      - 'null'
      - string
    doc: BAM FLAGs to use in checksums
    inputBinding:
      position: 102
      prefix: --flag-mask
  - id: no_rev_comp
    type:
      - 'null'
      - boolean
    doc: Do not reverse-complement sequences
    inputBinding:
      position: 102
      prefix: --no-rev-comp
  - id: tags
    type:
      - 'null'
      - type: array
        items: string
    doc: Select tags to checksum
    inputBinding:
      position: 102
      prefix: --tags
      itemSeparator: ','
  - id: in_order
    type:
      - 'null'
      - boolean
    doc: Use order-specific checksumming
    inputBinding:
      position: 102
      prefix: --in-order
  - id: check_pos
    type:
      - 'null'
      - boolean
    doc: Also checksum CHR / POS
    inputBinding:
      position: 102
      prefix: --check-pos
  - id: check_cigar
    type:
      - 'null'
      - boolean
    doc: Also checksum MAPQ / CIGAR
    inputBinding:
      position: 102
      prefix: --check-cigar
  - id: check_mate
    type:
      - 'null'
      - boolean
    doc: Also checksum PNEXT / RNEXT / TLEN
    inputBinding:
      position: 102
      prefix: --check_mate
  - id: sanitize
    type:
      - 'null'
      - string
    doc: Perform sanity checks and fix records
    inputBinding:
      position: 102
      prefix: --sanitize
  - id: count
    type:
      - 'null'
      - int
    doc: Stop after INT number of records
    inputBinding:
      position: 102
      prefix: --count
  - id: output
    type:
      - 'null'
      - string
    doc: Write report to FILE
    inputBinding:
      position: 102
      prefix: --output
  - id: show_qc
    type:
      - 'null'
      - boolean
    doc: Also show QC pass/fail lines
    inputBinding:
      position: 102
      prefix: --show-qc
  - id: all
    type:
      - 'null'
      - boolean
    doc: 'Check all: -PCMOc -b 0xfff -f0 -F0 -z all,cigarx'
    inputBinding:
      position: 102
      prefix: --all
  - id: tabs
    type:
      - 'null'
      - boolean
    doc: Format output as tab delimited text
    inputBinding:
      position: 102
      prefix: --tabs
  - id: merge
    type:
      - 'null'
      - File
    doc: Merge checksum output (-o opt) files
    inputBinding:
      position: 102
      prefix: --merge
  - id: bamseqchksum
    type:
      - 'null'
      - boolean
    doc: Report in bamseqchksum format
    inputBinding:
      position: 102
      prefix: --bamseqchksum
  - id: input_fmt_option
    type:
      - 'null'
      - string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 102
      prefix: --input-fmt-option
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: Write report to FILE
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
