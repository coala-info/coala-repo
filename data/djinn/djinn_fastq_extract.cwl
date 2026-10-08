cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - djinn
  - fastq
  - extract
label: djinn_fastq_extract
doc: "Extract all barcodes\n\nTool homepage: https://github.com/pdimens/djinn"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: 'Input FASTQ file(s): R1 and optional R2 (can be gzipped)'
    inputBinding:
      position: 101
outputs:
  - id: barcodes
    type: stdout
    doc: Extracted barcodes
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
stdout: djinn_fastq_extract.txt
