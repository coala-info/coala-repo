cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - bam-head
label: fuc_bam-head
doc: "Print the header of a BAM file.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: bam
    type: File
    doc: Input alignment file.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_bam-head.out
