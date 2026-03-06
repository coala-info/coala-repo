cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- ampliconstats
label: samtools_ampliconstats
doc: "Produce statistics from amplicon sequencing alignment files\n\nTool homepage:
  https://github.com/samtools/samtools"
requirements:
- class: InlineJavascriptRequirement
inputs:
- id: primers_bed
  type: File
  doc: Primers in BED format
  inputBinding:
    position: 104
- id: input_bams
  type:
    type: array
    items: File
  doc: Input BAM files
  inputBinding:
    position: 105
- id: depth_bin
  type: float?
  doc: Merge FDP values within +/- FRACTION together
  inputBinding:
    position: 1
    prefix: --depth-bin
- id: filter_flag
  type: string?
  doc: Only include reads with none of the FLAGs present
  inputBinding:
    position: 1
    prefix: -F
- id: input_fmt
  type: string?
  doc: Specify input format (SAM, BAM, CRAM)
  inputBinding:
    position: 1
    prefix: --input-fmt
- id: input_fmt_option
  type: string?
  doc: Specify a single input file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 1
    prefix: --input-fmt-option
- id: max_amplicon_length
  type: int?
  doc: Change the maximum length of an individual amplicon
  inputBinding:
    position: 1
    prefix: -l
- id: max_amplicons
  type: int?
  doc: Change the maximum number of amplicons permitted
  inputBinding:
    position: 1
    prefix: -m
- id: min_depth
  type:
  - 'null'
  - int
  - type: array
    items: int
  doc: Minimum base depth(s) to consider position covered
  inputBinding:
    position: 1
    prefix: -d
    itemSeparator: ","
- id: pos_margin
  type: int?
  doc: Margin of error for matching primer positions
  inputBinding:
    position: 1
    prefix: -p
- id: reference
  type: File?
  doc: Reference sequence FASTA FILE
  inputBinding:
    position: 1
    prefix: --reference
- id: required_flag
  type: string?
  doc: Only include reads with all of the FLAGs present
  inputBinding:
    position: 1
    prefix: -f
- id: single_ref
  type: boolean?
  doc: Force single-ref (<=1.12) output format
  inputBinding:
    position: 1
    prefix: -s
- id: tcoord_bin
  type: int?
  doc: Bin template start,end positions into multiples of INT
  inputBinding:
    position: 1
    prefix: -b
- id: tcoord_min_count
  type: int?
  doc: Minimum template start,end frequency for recording
  inputBinding:
    position: 1
    prefix: -c
- id: threads
  type: int?
  doc: Number of additional threads to use
  inputBinding:
    position: 1
    prefix: -@
- id: tlen_adjust
  type: int?
  doc: Add/subtract from TLEN; use when clipping but no fixmate step
  inputBinding:
    position: 1
    prefix: -a
- id: use_sample_name
  type: boolean?
  doc: Use the sample name from the first @RG header line
  inputBinding:
    position: 1
    prefix: -u
stdout: stats.out
outputs:
- id: output_file
  type: stdout
  doc: Captured statistics output
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
