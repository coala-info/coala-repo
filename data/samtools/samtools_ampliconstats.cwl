cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- ampliconstats
label: samtools_ampliconstats
doc: 'Generate amplicon specific statistics


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: primers_bed
  type: File
  doc: BED file of primer positions.
  inputBinding:
    position: 104
- id: input_bams
  type:
    type: array
    items: File
  doc: Input SAM/BAM/CRAM files.
  inputBinding:
    position: 105
- id: required_flag
  type:
  - 'null'
  - string
  doc: Only include reads with all of the FLAGs present [0x0].
  inputBinding:
    position: 103
    prefix: --required-flag
- id: filter_flag
  type:
  - 'null'
  - string
  doc: Only include reads with none of the FLAGs present [0xB04].
  inputBinding:
    position: 103
    prefix: --filter-flag
- id: max_amplicons
  type:
  - 'null'
  - int
  doc: Change the maximum number of amplicons permitted [1000].
  inputBinding:
    position: 103
    prefix: --max-amplicons
- id: max_amplicon_length
  type:
  - 'null'
  - int
  doc: Change the maximum length of an individual amplicon [1000].
  inputBinding:
    position: 103
    prefix: --max-amplicon-length
- id: min_depth
  type:
  - 'null'
  - string
  doc: Minimum base depth(s) to consider position covered, INT[,INT]... [1].
  inputBinding:
    position: 103
    prefix: --min-depth
- id: pos_margin
  type:
  - 'null'
  - int
  doc: Margin of error for matching primer positions [30].
  inputBinding:
    position: 103
    prefix: --pos-margin
- id: output_filename
  type: string
  doc: Output file (-o).
  default: ampliconstats.txt
  inputBinding:
    position: 103
    prefix: -o
- id: use_sample_name
  type:
  - 'null'
  - boolean
  doc: Use the sample name from the first @RG header line.
  inputBinding:
    position: 103
    prefix: --use-sample-name
- id: tlen_adjust
  type:
  - 'null'
  - int
  doc: Add/subtract from TLEN; use when clipping but no fixmate step.
  inputBinding:
    position: 103
    prefix: --tlen-adjust
- id: tcoord_bin
  type:
  - 'null'
  - int
  doc: Bin template start,end positions into multiples of INT [1].
  inputBinding:
    position: 103
    prefix: --tcoord-bin
- id: tcoord_min_count
  type:
  - 'null'
  - int
  doc: Minimum template start,end frequency for recording [10].
  inputBinding:
    position: 103
    prefix: --tcoord-min-count
- id: depth_bin
  type:
  - 'null'
  - float
  doc: Merge FDP values within +/- FRACTION together.
  inputBinding:
    position: 103
    prefix: --depth-bin
- id: single_ref
  type:
  - 'null'
  - boolean
  doc: Force single-ref (<=1.12) output format.
  inputBinding:
    position: 103
    prefix: --single-ref
- id: input_fmt
  type:
  - 'null'
  - string
  doc: Specify input format FORMAT[,OPT[=VAL]]... (SAM, BAM, CRAM).
  inputBinding:
    position: 103
    prefix: --input-fmt
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
  doc: Amplicon statistics.
  outputBinding:
    glob: $(inputs.output_filename)
