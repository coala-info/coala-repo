cwlVersion: v1.2
class: CommandLineTool
baseCommand: maf_order
label: multiz_maf_order
doc: "maf_order: order the rows of each alignment block according to a given species list. Usage: maf_order maf-file species1 species2 .. [nohead] [all]. The alignment goes to standard output.\n\nTool homepage: http://www.bx.psu.edu/miller_lab/"
inputs:
  - id: maf_file
    type: File
    doc: Input MAF file
    inputBinding:
      position: 1
  - id: species
    type: string[]
    doc: Species names in the wanted row order
    inputBinding:
      position: 2
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not output the MAF header (nohead)
    inputBinding:
      position: 3
      valueFrom: "$(self ? \"nohead\" : null)"
  - id: all_blocks
    type:
      - 'null'
      - boolean
    doc: Also output single-row blocks (all)
    inputBinding:
      position: 4
      valueFrom: "$(self ? \"all\" : null)"
outputs:
  - id: ordered
    type: stdout
    doc: Row-ordered MAF alignment (standard output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiz:11.2--hec16e2b_3
stdout: maf_order.maf
