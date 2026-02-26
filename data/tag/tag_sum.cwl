cwlVersion: v1.2
class: CommandLineTool
baseCommand: tag_sum
label: tag_sum
doc: "Briefly summarize a GFF3 file\n\nTool homepage: https://github.com/standage/tag/"
inputs:
  - id: gff3
    type: File
    doc: input file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tag:0.5.1--py_0
stdout: tag_sum.out
