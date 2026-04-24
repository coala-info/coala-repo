cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bxtools
  - relabel
label: bxtools_relabel
doc: "Move BX barcodes from BX tag to qname\n\nTool homepage: https://github.com/walaj/bxtools"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - int
    doc: 'Select verbosity level (0-4). Default: 0'
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bxtools:0.1.0--h13024bc_6
stdout: bxtools_relabel.out
