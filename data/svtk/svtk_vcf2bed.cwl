cwlVersion: v1.2
class: CommandLineTool
baseCommand: svtk
label: svtk_vcf2bed
doc: "Convert a VCF to a BED.\n\nTool homepage: https://github.com/talkowski-lab/svtk"
inputs:
  - id: vcf
    type: File
    doc: VCF to convert.
    inputBinding:
      position: 1
  - id: include_filters
    type:
      - 'null'
      - boolean
    doc: Include FILTER status in output, with the same behavior an INFO field.
    inputBinding:
      position: 102
      prefix: --include-filters
  - id: info
    type:
      - 'null'
      - type: array
        items: string
    doc: INFO field to include as column in output. May be specified more than 
      once. To include all INFO fields, specify `--info ALL`. INFO fields are 
      reported in the order in which they are requested. If ALL INFO fields are 
      requested, they are reported in the order in which they appear in the VCF 
      header.
    inputBinding:
      position: 102
      prefix: --info
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Suppress header.
    inputBinding:
      position: 102
      prefix: --no-header
  - id: no_samples
    type:
      - 'null'
      - boolean
    doc: Don't include comma-delimited list of called samples for each variant.
    inputBinding:
      position: 102
      prefix: --no-samples
  - id: no_sort_coords
    type:
      - 'null'
      - boolean
    doc: Do not sort start/end coordinates per record before writing to bed.
    inputBinding:
      position: 102
      prefix: --no-sort-coords
  - id: no_unresolved
    type:
      - 'null'
      - boolean
    doc: Do not output unresolved variants.
    inputBinding:
      position: 102
      prefix: --no-unresolved
  - id: simple_sinks
    type:
      - 'null'
      - boolean
    doc: Report all INS sinks as 1bp intervals.
    inputBinding:
      position: 102
      prefix: --simple-sinks
  - id: split_bnd
    type:
      - 'null'
      - boolean
    doc: Report two entries in bed file for each BND.
    inputBinding:
      position: 102
      prefix: --split-bnd
  - id: split_cpx
    type:
      - 'null'
      - boolean
    doc: Report entries for each CPX rearrangement interval.
    inputBinding:
      position: 102
      prefix: --split-cpx
outputs:
  - id: bed
    type: File
    doc: Converted bed. Specify `-` or `stdout` to write to stdout.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
