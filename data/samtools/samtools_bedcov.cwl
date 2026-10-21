cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- bedcov
label: samtools_bedcov
doc: 'Read depth per BED region


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: in_bed
  type: File
  doc: BED file of regions.
  inputBinding:
    position: 104
- id: in_bam
  type:
    type: array
    items: File
  doc: Input sorted, indexed alignment files.
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: .csi
    required: false
  - pattern: .crai
    required: false
  - pattern: ^.bai
    required: false
  inputBinding:
    position: 105
- id: min_mq
  type:
  - 'null'
  - int
  doc: Mapping quality threshold [0].
  inputBinding:
    position: 103
    prefix: --min-MQ
- id: custom_index
  type:
  - 'null'
  - boolean
  doc: Use customized index files.
  inputBinding:
    position: 103
    prefix: -X
- id: remove_flags
  type:
  - 'null'
  - string
  doc: Remove the specified flags from the set used to filter out reads (-g).
  inputBinding:
    position: 103
    prefix: -g
- id: add_flags
  type:
  - 'null'
  - string
  doc: Add the specified flags to the set used to filter out reads (-G); default set is 0x704.
  inputBinding:
    position: 103
    prefix: -G
- id: ignore_deletions_and_skips
  type:
  - 'null'
  - boolean
  doc: Do not include deletions (D) and ref skips (N) in bedcov computation.
  inputBinding:
    position: 103
    prefix: -j
- id: max_depth
  type:
  - 'null'
  - int
  doc: Sets the maximum depth used in the mpileup algorithm.
  inputBinding:
    position: 103
    prefix: --max-depth
- id: depth_threshold
  type:
  - 'null'
  - int
  doc: Depth threshold; reference bases with coverage at or above this value are shown in a separate column.
  inputBinding:
    position: 103
    prefix: -d
- id: read_count
  type:
  - 'null'
  - boolean
  doc: Add an additional column showing read count.
  inputBinding:
    position: 103
    prefix: -c
- id: header
  type:
  - 'null'
  - boolean
  doc: Print a comment/header line with column information.
  inputBinding:
    position: 103
    prefix: -H
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
  doc: Name of the file that receives standard output.
  default: bedcov.tsv
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
  doc: BED regions with the total read depth per region.
  outputBinding:
    glob: $(inputs.output_filename)
stdout: $(inputs.output_filename)
