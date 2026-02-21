cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - colorid_bv
  - read_filter
label: colorid_bv_read_filter
doc: "filters reads\n\nTool homepage: https://github.com/hcdenbakker/colorid_bv"
inputs:
  - id: classification
    type: File
    doc: tab delimited read classification file generated with the read_id subcommand
    inputBinding:
      position: 101
      prefix: --classification
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: If set('-e or --exclude'), reads for which the classification contains the
      taxon name will be excluded
    inputBinding:
      position: 101
      prefix: --exclude
  - id: files
    type:
      type: array
      items: File
    doc: query file(-s)fastq.gz
    inputBinding:
      position: 101
      prefix: --files
  - id: taxon
    type: string
    doc: taxon to be in- or excluded from the read file(-s)
    inputBinding:
      position: 101
      prefix: --taxon
outputs:
  - id: prefix
    type: File
    doc: prefix for output file(-s)
    outputBinding:
      glob: $(inputs.prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/colorid_bv:0.1.0--h3ab6199_2
