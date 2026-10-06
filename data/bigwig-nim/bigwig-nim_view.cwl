cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bigwig, view]
label: bigwig-nim_view
doc: "view and convert bigwig\n\nTool homepage: https://github.com/brentp/bigwig-nim"
inputs:
  - id: input
    type: File
    doc: input BigWig file, or BED/bedGraph file (optionally gzipped) when converting to BigWig
    inputBinding:
      position: 10
  - id: region
    type:
      - 'null'
      - string
    doc: optional chromosome, or chrom:start-stop region to view
    inputBinding:
      position: 1
      prefix: --region=
      separate: false
  - id: chrom_sizes
    type:
      - 'null'
      - File
    doc: file indicating chromosome sizes (can be .fai), only used for converting BED->BigWig
    inputBinding:
      position: 1
      prefix: --chrom-sizes=
      separate: false
  - id: value_column
    type:
      - 'null'
      - int
    doc: 'column-number (1-based) of the value to encode in to BigWig, only used for encoding BED->BigWig
      (default: 4)'
    inputBinding:
      position: 1
      prefix: --value-column=
      separate: false
  - id: output_fmt
    type:
      - 'null'
      - type: enum
        symbols:
          - bed
          - bigwig
    doc: 'output format (default: bed)'
    inputBinding:
      position: 1
      prefix: --output-fmt=
      separate: false
  - id: output_file
    type: string
    doc: output bed or bigwig file name
    inputBinding:
      position: 1
      prefix: --output-file=
      separate: false
    default: output.bed
outputs:
  - id: output
    type: File
    doc: Output BED or BigWig file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigwig-nim:0.0.3--h9ee0642_0
