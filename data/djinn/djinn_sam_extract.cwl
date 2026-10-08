cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - djinn
  - sam
  - extract
label: djinn_sam_extract
doc: "Extract all barcodes\n\nTool homepage: https://github.com/pdimens/djinn"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input
    type: File
    doc: Input SAM/BAM file
    inputBinding:
      position: 101
outputs:
  - id: barcodes
    type: stdout
    doc: Extracted barcodes
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
stdout: djinn_sam_extract.txt
