cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_covered
label: multiz_get_covered
doc: "get_covered: get the parts of file2 that are covered by the alignment blocks of file1. Usage: get_covered file1 file2. The result goes to standard output.\n\nTool homepage: http://www.bx.psu.edu/miller_lab/"
inputs:
  - id: file1
    type: File
    doc: First MAF file
    inputBinding:
      position: 1
  - id: file2
    type: File
    doc: Second MAF file
    inputBinding:
      position: 2
outputs:
  - id: covered
    type: stdout
    doc: Covered alignments in MAF format (standard output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiz:11.2--hec16e2b_3
stdout: get_covered.maf
