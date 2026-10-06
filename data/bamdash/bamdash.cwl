cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamdash
label: bamdash
doc: "Generate a coverage plot from BAM files.\n\nTool homepage: https://github.com/jonas-fuchs/BAMdash"
inputs:
  - id: bam_file
    type: File
    doc: bam file location (indexed; the .bai must sit beside it)
    secondaryFiles:
      - .bai
    inputBinding:
      position: 101
      prefix: --bam
  - id: binsize
    type:
      - 'null'
      - int
    doc: bins for the coverage plot
    inputBinding:
      position: 101
      prefix: --binsize
  - id: coverage
    type:
      - 'null'
      - int
    doc: minimum coverage
    inputBinding:
      position: 101
      prefix: --coverage
  - id: dimensions
    type:
      - 'null'
      - type: array
        items: int
    doc: width and height of the static image in px (two integers)
    inputBinding:
      position: 101
      prefix: --dimensions
  - id: dump_data
    type:
      - 'null'
      - boolean
    doc: dump annotated track data
    inputBinding:
      position: 101
      prefix: --dump
  - id: export_static
    type:
      - 'null'
      - string
    doc: export as png, jpg, pdf, svg
    inputBinding:
      position: 101
      prefix: --export_static
  - id: no_dump
    type:
      - 'null'
      - boolean
    doc: do not dump annotated track data
    inputBinding:
      position: 101
      prefix: --no-dump
  - id: no_slider
    type:
      - 'null'
      - boolean
    doc: hide slider
    inputBinding:
      position: 101
      prefix: --no-slider
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: qaulity threshold for reads
    inputBinding:
      position: 101
      prefix: --quality-threshold
  - id: reference_id
    type: string
    doc: seq reference id
    inputBinding:
      position: 101
      prefix: --reference
  - id: show_slider
    type:
      - 'null'
      - boolean
    doc: show slider
    inputBinding:
      position: 101
      prefix: --slider
  - id: tracks
    type:
      - 'null'
      - type: array
        items: File
    doc: file location of tracks
    inputBinding:
      position: 101
      prefix: --tracks
outputs:
  - id: plot_html
    type: File
    doc: Interactive coverage plot (<reference>_plot.html)
    outputBinding:
      glob: $(inputs.reference_id)_plot.html
  - id: static_plot
    type:
      - 'null'
      - File
    doc: Static plot written when export_static is set (<reference>_plot.<format>)
    outputBinding:
      glob: "$(inputs.export_static ? inputs.reference_id + '_plot.' + inputs.export_static : [])"
  - id: dumped_data
    type:
      type: array
      items: File
    doc: Track data and BAM statistics written with --dump
    outputBinding:
      glob:
        - $(inputs.reference_id)_*.tabular
        - $(inputs.reference_id)_gb_data_*.json
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamdash:0.4.5--pyhdfd78af_0
