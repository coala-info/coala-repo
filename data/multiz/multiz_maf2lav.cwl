cwlVersion: v1.2
class: CommandLineTool
baseCommand: maf2lav
label: multiz_maf2lav
doc: "maf2lav: convert a MAF alignment to LAV format. Usage: maf2lav align.maf seq1 seq2. The LAV alignment goes to standard output.\n\nTool homepage: http://www.bx.psu.edu/miller_lab/"
inputs:
  - id: maf_file
    type: File
    doc: Input MAF file
    inputBinding:
      position: 1
  - id: seq1
    type: File
    doc: Sequence file of the first species
    inputBinding:
      position: 2
  - id: seq2
    type: File
    doc: Sequence file of the second species
    inputBinding:
      position: 3
outputs:
  - id: lav
    type: stdout
    doc: LAV alignment (standard output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiz:11.2--hec16e2b_3
stdout: maf2lav.lav
