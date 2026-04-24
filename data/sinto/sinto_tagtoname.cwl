cwlVersion: v1.2
class: CommandLineTool
baseCommand: sinto_tagtoname
label: sinto_tagtoname
doc: "Copy cell barcode sequences from tag to read names. Cell barcodes will be added
  as a readname prefix, followed by \":\"\n\nTool homepage: https://timoast.github.io/sinto/"
inputs:
  - id: bam_file
    type: File
    doc: Input SAM/BAM file, '-' reads from stdin
    inputBinding:
      position: 101
      prefix: --bam
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format. One of 't' (SAM), 'b' (BAM), or 'u' (uncompressed BAM)
    inputBinding:
      position: 101
      prefix: --outputformat
  - id: tag
    type:
      - 'null'
      - string
    doc: Read tag to copy from.
    inputBinding:
      position: 101
      prefix: --tag
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output SAM/BAM file, '-' outputs to stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sinto:0.10.1--pyhdfd78af_0
