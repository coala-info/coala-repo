cwlVersion: v1.2
class: CommandLineTool
baseCommand: PAFtoPSL
label: fastga_PAFtoPSL
doc: "Converts a PAF file with CIGAR strings to PSL format.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs:
  - id: alignments
    type: File
    doc: Alignment file in PAF format with CIGAR strings.
    inputBinding:
      position: 100
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use. [default: 8]'
    inputBinding:
      position: 101
      prefix: '-T'
      separate: false
  - id: cigar_tag
    type:
      - 'null'
      - string
    doc: 'Cigar tag in the PAF file. [default: cg:Z:]'
    inputBinding:
      position: 101
      prefix: '-C'
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_PAFtoPSL.out
