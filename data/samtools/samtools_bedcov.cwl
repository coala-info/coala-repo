cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - bedcov
label: samtools_bedcov
doc: Calculate read coverage across genomic regions specified in a BED file
inputs:
  - id: in_bed
    type: File
    doc: Input BED file defining regions
    inputBinding:
      position: 1
  - id: in_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: Input BAM file(s)
    inputBinding:
      position: 2
  - id: min_mq
    type:
      - 'null'
      - int
    doc: mapping quality threshold [0]
    inputBinding:
      position: 103
      prefix: --min-MQ
  - id: custom_index
    type:
      - 'null'
      - boolean
    doc: use customized index files
    inputBinding:
      position: 103
      prefix: -X
  - id: remove_flags
    type:
      - 'null'
      - string
    doc: remove the specified flags from the set used to filter out reads
    inputBinding:
      position: 103
      prefix: -g
  - id: add_flags
    type:
      - 'null'
      - string
    doc: add the specified flags to the set used to filter out reads. The 
      default set is UNMAP,SECONDARY,QCFAIL,DUP or 0x704
    inputBinding:
      position: 103
      prefix: -G
  - id: ignore_deletions_and_skips
    type:
      - 'null'
      - boolean
    doc: do not include deletions (D) and ref skips (N) in bedcov computation
    inputBinding:
      position: 103
      prefix: -j
  - id: max_depth
    type:
      - 'null'
      - int
    doc: sets the maximum depth used in the mpileup algorithm
    inputBinding:
      position: 103
      prefix: --max-depth
  - id: depth_threshold
    type:
      - 'null'
      - int
    doc: depth threshold. Number of reference bases with coverage above and 
      including this value will be displayed in a separate column
    inputBinding:
      position: 103
      prefix: -d
  - id: read_count
    type:
      - 'null'
      - boolean
    doc: add an additional column showing read count
    inputBinding:
      position: 103
      prefix: -c
  - id: header
    type:
      - 'null'
      - boolean
    doc: print a comment/header line with column information.
    inputBinding:
      position: 103
      prefix: -H
  - id: input_fmt_option
    type:
      - 'null'
      - string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 103
      prefix: --input-fmt-option
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
stdout: samtools_bedcov.out
s:url: https://github.com/samtools/samtools
$namespaces:
  s: https://schema.org/
