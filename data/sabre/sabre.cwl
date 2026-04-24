cwlVersion: v1.2
class: CommandLineTool
baseCommand: sabre
label: sabre
doc: "A barcode demultiplexing tool for FASTQ files. It can handle both single-end
  and paired-end data.\n\nTool homepage: https://github.com/najoshi/sabre/"
inputs:
  - id: subcommand
    type: string
    doc: "The demultiplexing mode: 'pe' (paired-end) or 'se' (single-end)"
    inputBinding:
      position: 1
  - id: barcode_file
    type: File
    doc: Barcode data file
    inputBinding:
      position: 102
      prefix: -b
  - id: forward_fastq
    type: File
    doc: Input forward fastq file (or single-end file)
    inputBinding:
      position: 102
      prefix: -f
  - id: mismatches
    type:
      - 'null'
      - int
    doc: Maximum number of allowed mismatches
    inputBinding:
      position: 102
      prefix: -m
  - id: reverse_fastq
    type:
      - 'null'
      - File
    doc: Input reverse fastq file (for paired-end)
    inputBinding:
      position: 102
      prefix: -r
outputs:
  - id: unknown_output_f
    type:
      - 'null'
      - File
    doc: File to write reads with unknown barcodes to
    outputBinding:
      glob: $(inputs.unknown_output_f)
  - id: unknown_output_r
    type:
      - 'null'
      - File
    doc: File to write reverse reads with unknown barcodes to (for paired-end)
    outputBinding:
      glob: $(inputs.unknown_output_r)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sabre:1.000--h577a1d6_6
