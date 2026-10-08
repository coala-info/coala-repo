cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ema
  - count
label: ema_count
doc: "perform preliminary barcode count (takes interleaved FASTQ via stdin)\n\nTool
  homepage: https://github.com/arshajii/ema"
inputs:
  - id: interleaved_fastq
    type: File
    doc: interleaved barcoded FASTQ, read from standard input
  - id: haplotag_barcodes
    type:
      - 'null'
      - boolean
    doc: using haplotag barcodes
    inputBinding:
      position: 102
      prefix: -p
  - id: output_prefix
    type: string
    doc: specify output prefix [required]
    inputBinding:
      position: 102
      prefix: -o
  - id: whitelist_path
    type:
      - 'null'
      - File
    doc: specify barcode whitelist [required, unless using -p option]
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: ncnt_file
    type: File
    doc: barcode counts file (prefix.ema-ncnt)
    outputBinding:
      glob: $(inputs.output_prefix).ema-ncnt
  - id: fcnt_file
    type: File
    doc: full counts file (prefix.ema-fcnt)
    outputBinding:
      glob: $(inputs.output_prefix).ema-fcnt
  - id: stderr_log
    type: stderr
    doc: log messages written to standard error
stdin: $(inputs.interleaved_fastq.path)
stderr: ema_count.log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ema:0.7.0--h5ca1c30_2
