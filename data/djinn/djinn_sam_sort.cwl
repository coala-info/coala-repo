cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - djinn
  - sam
  - sort
label: djinn_sam_sort
doc: "Sort by barcode\n\nTool homepage: https://github.com/pdimens/djinn"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (minimum 6)
    inputBinding:
      position: 1
      prefix: --threads
  - id: sam
    type:
      - 'null'
      - boolean
    doc: Output as SAM instead of BAM
    inputBinding:
      position: 1
      prefix: --sam
  - id: sam_tag
    type: string
    doc: SAM tag that holds the barcode (e.g. BX, BC)
    inputBinding:
      position: 101
  - id: input
    type: File
    doc: Input SAM/BAM file
    inputBinding:
      position: 102
outputs:
  - id: output_alignments
    type: stdout
    doc: Alignments sorted by barcode
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
stdout: '$(inputs.sam ? ''djinn_sam_sort.sam'' : ''djinn_sam_sort.bam'')'
