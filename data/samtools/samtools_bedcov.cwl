cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- bedcov
label: samtools_bedcov
doc: "Calculate read depth per BED region\n\nTool homepage: https://github.com/samtools/samtools"
requirements:
  InlineJavascriptRequirement: {}
inputs:
- id: input_bed
  type: File
  doc: Input BED file
  inputBinding:
    position: 101
- id: input_bams
  type:
    type: array
    items: File
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: ^.bai
    required: false
  doc: One or more input BAM files
  inputBinding:
    position: 102
- id: add_flags
  type: string?
  doc: "add the specified flags to the set used to filter out reads. The default \n\
    set is UNMAP,SECONDARY,QCFAIL,DUP or 0x704"
  inputBinding:
    position: 1
    prefix: -G
- id: custom_index
  type: boolean?
  doc: use customized index files
  inputBinding:
    position: 1
    prefix: -X
- id: depth_threshold
  type: int?
  doc: "depth threshold. Number of reference bases with coverage above and \nincluding
    this value will be displayed in a separate column"
  inputBinding:
    position: 1
    prefix: -d
- id: exclude_deletions_skips
  type: boolean?
  doc: do not include deletions (D) and ref skips (N) in bedcov computation
  inputBinding:
    position: 1
    prefix: -j
- id: input_fmt_option
  type: string[]?
  doc: Specify a single input file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 1
    prefix: --input-fmt-option
- id: max_depth
  type: int?
  doc: sets the maximum depth used in the mpileup algorithm
  inputBinding:
    position: 1
    prefix: --max-depth
- id: min_mq
  type: int?
  doc: mapping quality threshold
  inputBinding:
    position: 1
    prefix: --min-MQ
- id: print_header
  type: boolean?
  doc: print a comment/header line with column information.
  inputBinding:
    position: 1
    prefix: -H
- id: read_count_column
  type: boolean?
  doc: add an additional column showing read count
  inputBinding:
    position: 1
    prefix: -c
- id: reference
  type: File?
  doc: Reference sequence FASTA FILE
  inputBinding:
    position: 1
    prefix: --reference
- id: remove_flags
  type: string?
  doc: remove the specified flags from the set used to filter out reads
  inputBinding:
    position: 1
    prefix: -g
- id: verbosity
  type: int?
  doc: Set level of verbosity
  inputBinding:
    position: 1
    prefix: --verbosity
outputs:
- id: stdout
  type: stdout
  doc: Standard output
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
stdout: samtools_bedcov.out
