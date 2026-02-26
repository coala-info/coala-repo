cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - umis
  - cb_histogram
label: umis_cb_histogram
doc: "Counts the number of reads for each cellular barcode\n\nExpects formatted fastq
  files.\n\nTool homepage: https://github.com/vals/umis"
inputs:
  - id: fastq
    type: File
    doc: Formatted fastq file
    inputBinding:
      position: 1
outputs:
  - id: umi_histogram
    type:
      - 'null'
      - File
    doc: Output a count of each UMI for each cellular barcode to this file.
    outputBinding:
      glob: $(inputs.umi_histogram)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
