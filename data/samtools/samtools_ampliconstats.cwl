cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - samtools
  - ampliconstats
label: samtools_ampliconstats
doc: "Produce statistics from amplicon sequencing alignment files\n\nTool homepage:
  https://github.com/samtools/samtools"
inputs:
  - id: primers_bed
    type: File
    doc: Primers in BED format
    inputBinding:
      position: 1
  - id: input_bams
    type:
      type: array
      items: File
    doc: Input BAM files
    inputBinding:
      position: 2
  - id: depth_bin
    type:
      - 'null'
      - float
    doc: Merge FDP values within +/- FRACTION together
    inputBinding:
      position: 103
      prefix: --depth-bin
  - id: filter_flag
    type:
      - 'null'
      - string
    doc: Only include reads with none of the FLAGs present
    default: '0xB04'
    inputBinding:
      position: 103
      prefix: --filter-flag
  - id: input_fmt
    type:
      - 'null'
      - string
    doc: Specify input format (SAM, BAM, CRAM)
    inputBinding:
      position: 103
      prefix: --input-fmt
  - id: input_fmt_option
    type:
      - 'null'
      - string
    doc: Specify a single input file format option in the form of OPTION or 
      OPTION=VALUE
    inputBinding:
      position: 103
      prefix: --input-fmt-option
  - id: max_amplicon_length
    type:
      - 'null'
      - int
    doc: Change the maximum length of an individual amplicon
    default: 1000
    inputBinding:
      position: 103
      prefix: --max-amplicon-length
  - id: max_amplicons
    type:
      - 'null'
      - int
    doc: Change the maximum number of amplicons permitted
    default: 1000
    inputBinding:
      position: 103
      prefix: --max-amplicons
  - id: min_depth
    type:
      - 'null'
      - type: array
        items: int
    doc: Minimum base depth(s) to consider position covered
    default: 1
    inputBinding:
      position: 103
      prefix: --min-depth
  - id: pos_margin
    type:
      - 'null'
      - int
    doc: Margin of error for matching primer positions
    default: 30
    inputBinding:
      position: 103
      prefix: --pos-margin
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence FASTA FILE
    inputBinding:
      position: 103
      prefix: --reference
  - id: required_flag
    type:
      - 'null'
      - string
    doc: Only include reads with all of the FLAGs present
    default: '0x0'
    inputBinding:
      position: 103
      prefix: --required-flag
  - id: single_ref
    type:
      - 'null'
      - boolean
    doc: Force single-ref (<=1.12) output format
    inputBinding:
      position: 103
      prefix: --single-ref
  - id: tcoord_bin
    type:
      - 'null'
      - int
    doc: Bin template start,end positions into multiples of INT
    default: 1
    inputBinding:
      position: 103
      prefix: --tcoord-bin
  - id: tcoord_min_count
    type:
      - 'null'
      - int
    doc: Minimum template start,end frequency for recording
    default: 10
    inputBinding:
      position: 103
      prefix: --tcoord-min-count
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use
    default: 0
    inputBinding:
      position: 103
      prefix: --threads
  - id: tlen_adjust
    type:
      - 'null'
      - int
    doc: Add/subtract from TLEN; use when clipping but no fixmate step
    inputBinding:
      position: 103
      prefix: --tlen-adjust
  - id: use_sample_name
    type:
      - 'null'
      - boolean
    doc: Use the sample name from the first @RG header line
    inputBinding:
      position: 103
      prefix: --use-sample-name
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Specify output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
