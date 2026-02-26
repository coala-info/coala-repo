cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - umis
  - demultiplex_samples
label: umis_demultiplex_samples
doc: "Demultiplex a fastqtransformed FASTQ file into a FASTQ file for each sample.\n\
  \nTool homepage: https://github.com/vals/umis"
inputs:
  - id: fastq
    type: File
    doc: fastqtransformed FASTQ file
    inputBinding:
      position: 1
  - id: barcodes
    type:
      - 'null'
      - File
    doc: File containing barcodes
    inputBinding:
      position: 102
      prefix: --barcodes
  - id: nedit
    type:
      - 'null'
      - int
    doc: Maximum number of edits allowed in barcodes
    inputBinding:
      position: 102
      prefix: --nedit
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 102
      prefix: --out_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
stdout: umis_demultiplex_samples.out
