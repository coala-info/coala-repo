cwlVersion: v1.2
class: CommandLineTool
baseCommand: ALNtoPAF
label: fastga_ALNtoPAF
doc: "Convert ALN alignment files to PAF format.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs:
  - id: alignment_file
    type: File
    doc: Input ALN alignment file
    inputBinding:
      position: 1
  - id: produce_cigar_m
    type:
      - 'null'
      - boolean
    doc: produce Cigar string tag with M's
    inputBinding:
      position: 102
      prefix: -m
  - id: produce_cigar_x
    type:
      - 'null'
      - boolean
    doc: produce Cigar string tag with X's and ='s
    inputBinding:
      position: 102
      prefix: -x
  - id: produce_cs_long
    type:
      - 'null'
      - boolean
    doc: produce CS string tag in long form
    inputBinding:
      position: 102
      prefix: -S
  - id: produce_cs_short
    type:
      - 'null'
      - boolean
    doc: produce CS string tag in short form
    inputBinding:
      position: 102
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Use -T threads.
    default: 8
    inputBinding:
      position: 102
      prefix: -T
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_ALNtoPAF.out
