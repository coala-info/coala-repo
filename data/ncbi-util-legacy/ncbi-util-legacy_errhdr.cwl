cwlVersion: v1.2
class: CommandLineTool
baseCommand: errhdr
label: ncbi-util-legacy_errhdr
doc: "Prints error header information.\n\nTool homepage: ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/"
inputs:
  - id: msgfile
    type: File
    doc: Message file
    inputBinding:
      position: 1
  - id: hdrfile
    type:
      - 'null'
      - File
    doc: Header file
    inputBinding:
      position: 2
  - id: code_subcode_tuples
    type:
      - 'null'
      - boolean
    doc: for code,subcode tuples
    inputBinding:
      position: 103
      prefix: '-2'
  - id: short_subcode_defines
    type:
      - 'null'
      - boolean
    doc: for short subcode defines
    inputBinding:
      position: 103
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-util-legacy:6.1--h0e27e84_3
stdout: ncbi-util-legacy_errhdr.out
