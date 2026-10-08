cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - djinn
  - sam
  - filter-invalid
label: djinn_sam_filter_invalid
doc: "Retain only valid-barcoded reads\n\nTool homepage: https://github.com/pdimens/djinn"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: invalid
    type:
      - 'null'
      - string
    doc: Output records with invalid barcodes to this file
    inputBinding:
      position: 1
      prefix: --invalid
  - id: sam
    type:
      - 'null'
      - boolean
    doc: Output as SAM instead of BAM
    inputBinding:
      position: 1
      prefix: --sam
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (minimum 2)
    inputBinding:
      position: 1
      prefix: --threads
  - id: input
    type: File
    doc: Input SAM/BAM file
    inputBinding:
      position: 101
outputs:
  - id: output_alignments
    type: stdout
    doc: Records with valid barcodes
  - id: invalid_records
    type: File?
    doc: Records with invalid barcodes, with --invalid
    outputBinding:
      glob: '$(inputs.invalid ? inputs.invalid : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
stdout: '$(inputs.sam ? ''djinn_sam_filter_invalid.sam'' : ''djinn_sam_filter_invalid.bam'')'
