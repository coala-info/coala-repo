cwlVersion: v1.2
class: CommandLineTool
baseCommand: netToAxt
label: ucsc-nettoaxt
doc: "Convert net and chain files to axt format, which is a format for representing
  alignments between two sequences.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: net_file
    type: File
    doc: Input net file.
    inputBinding:
      position: 1
  - id: chain_file
    type: File
    doc: Input chain file.
    inputBinding:
      position: 2
  - id: target_db
    type: File
    doc: Target 2bit file or directory of nib files.
    inputBinding:
      position: 3
  - id: query_db
    type: File
    doc: Query 2bit file or directory of nib files.
    inputBinding:
      position: 4
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Maximum gap size to allow in axt.
    inputBinding:
      position: 105
      prefix: -maxGap
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set verbosity level (e.g., -verbose=2).
    inputBinding:
      position: 105
      prefix: -verbose
outputs:
  - id: output_axt
    type: File
    doc: Output axt file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-nettoaxt:482--h0b57e2e_0
