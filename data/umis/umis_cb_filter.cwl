cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - umis
  - cb_filter
label: umis_cb_filter
doc: "Filters reads with non-matching barcodes Expects formatted fastq files.\n\n\
  Tool homepage: https://github.com/vals/umis"
inputs:
  - id: fastq
    type: File
    doc: FASTQ file to filter
    inputBinding:
      position: 1
  - id: bc1
    type: string
    doc: Barcode 1
    inputBinding:
      position: 102
      prefix: --bc1
  - id: bc2
    type:
      - 'null'
      - string
    doc: Barcode 2
    inputBinding:
      position: 102
      prefix: --bc2
  - id: bc3
    type:
      - 'null'
      - string
    doc: Barcode 3
    inputBinding:
      position: 102
      prefix: --bc3
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to use
    inputBinding:
      position: 102
      prefix: --cores
  - id: nedit
    type:
      - 'null'
      - int
    doc: Maximum number of edits allowed for barcode matching
    inputBinding:
      position: 102
      prefix: --nedit
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
stdout: umis_cb_filter.out
