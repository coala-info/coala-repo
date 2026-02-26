cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - umis
  - sb_filter
label: umis_sb_filter
doc: "Filters reads with non-matching sample barcodes Expects formatted fastq files.\n\
  \nTool homepage: https://github.com/vals/umis"
inputs:
  - id: fastq
    type: File
    doc: FASTQ file
    inputBinding:
      position: 1
  - id: bc
    type:
      - 'null'
      - File
    doc: Sample barcode file
    inputBinding:
      position: 102
      prefix: --bc
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
stdout: umis_sb_filter.out
