cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafFind
label: multiz_mafFind
doc: "mafFind: find the MAF blocks that intersect a given interval. Usage: mafFind file.maf beg end [species-prefix] [slice]. The blocks go to standard output.\n\nTool homepage: http://www.bx.psu.edu/miller_lab/"
inputs:
  - id: maf_file
    type: File
    doc: Input MAF file
    inputBinding:
      position: 1
  - id: beg
    type: int
    doc: Start of the interval
    inputBinding:
      position: 2
  - id: end
    type: int
    doc: End of the interval
    inputBinding:
      position: 3
  - id: species_prefix
    type:
      - 'null'
      - string
    doc: Species name prefix that the interval refers to
    inputBinding:
      position: 4
  - id: slice
    type:
      - 'null'
      - boolean
    doc: Cut the blocks to the interval (slice)
    inputBinding:
      position: 5
      valueFrom: "$(self ? \"slice\" : null)"
outputs:
  - id: blocks
    type: stdout
    doc: Selected MAF blocks (standard output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiz:11.2--hec16e2b_3
stdout: mafFind.maf
