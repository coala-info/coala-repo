cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - fuc-undetm
label: fuc_fuc-undetm
doc: "Compute top unknown barcodes using undertermined FASTQ from bcl2fastq.\n\nTool
  homepage: https://github.com/sbslee/fuc"
inputs:
  - id: fastq
    type: File
    doc: Undertermined FASTQ (compressed or uncompressed).
    inputBinding:
      position: 1
  - id: count
    type:
      - 'null'
      - int
    doc: Number of top unknown barcodes to return
    inputBinding:
      position: 102
      prefix: --count
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_fuc-undetm.out
