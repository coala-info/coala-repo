cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- checksum
label: samtools_checksum
doc: "Generate checksums for SAM/BAM/CRAM files or merge existing checksum outputs.\n\
  \nTool homepage: https://github.com/samtools/samtools"
requirements:
- class: InlineJavascriptRequirement
inputs:
- id: input_files
  type:
  - 'null'
  - type: array
    items: File
  doc: Input BAM/SAM/CRAM files or checksum files if merging
  inputBinding:
    position: 1
- id: all
  type:
  - 'null'
  - boolean
  doc: 'Check all: -PCMOc -b 0xfff -f0 -F0 -z all,cigarx'
  inputBinding:
    position: 102
    prefix: --all
- id: bamseqchksum
  type:
  - 'null'
  - boolean
  doc: Report in bamseqchksum format
  inputBinding:
    position: 102
    prefix: --bamseqchksum
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
- id: check_pos
  type:
  - 'null'
  - boolean
  doc: Also checksum CHR / POS
  inputBinding:
    position: 102
    prefix: --check-pos
- id: count
  type:
  - 'null'
  - int
  doc: Stop after INT number of records
  default: 0
  inputBinding:
    position: 102
    prefix: --count
- id: exclude_flags
  type:
  - 'null'
  - string
  doc: Filter if any FLAGs are present
  default: '0x900'
  inputBinding:
    position: 102
    prefix: --exclude-flags
- id: flag_mask
  type:
  - 'null'
  - string
  doc: BAM FLAGs to use in checksums
  default: '0x0c1'
  inputBinding:
    position: 102
    prefix: --flag-mask
- id: in_order
  type:
  - 'null'
  - boolean
  doc: Use order-specific checksumming
  inputBinding:
    position: 102
    prefix: --in-order
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
- id: merge
  type:
  - 'null'
  - File
  doc: Merge checksum output (-o opt) files
  inputBinding:
    position: 102
    prefix: --merge
- id: no_rev_comp
  type:
  - 'null'
  - boolean
  doc: Do not reverse-complement sequences
  inputBinding:
    position: 102
    prefix: --no-rev-comp
- id: require_flags
  type:
  - 'null'
  - string
  doc: Filter unless all FLAGs are present
  default: '0'
  inputBinding:
    position: 102
    prefix: --require-flags
- id: sanitize
  type:
  - 'null'
  - string
  doc: Perform sanity checks and fix records
  inputBinding:
    position: 102
    prefix: --sanitize
- id: show_qc
  type:
  - 'null'
  - boolean
  doc: Also show QC pass/fail lines
  inputBinding:
    position: 102
    prefix: --show-qc
- id: tabs
  type:
  - 'null'
  - boolean
  doc: Format output as tab delimited text
  inputBinding:
    position: 102
    prefix: --tabs
- id: tags
  type:
  - 'null'
  - string
  doc: Select tags to checksum
  default: BC,FI,QT,RT,TC
  inputBinding:
    position: 102
    prefix: --tags
- id: threads
  type:
  - 'null'
  - int
  doc: Number of additional threads to use
  default: 0
  inputBinding:
    position: 102
    prefix: --threads
- id: verbose
  type:
  - 'null'
  - boolean
  doc: 'Increase verbosity: show lines with 0 counts'
  inputBinding:
    position: 102
    prefix: --verbose
stdout: checksum.txt
outputs:
- id: output
  type: stdout
  doc: Write report to FILE
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
