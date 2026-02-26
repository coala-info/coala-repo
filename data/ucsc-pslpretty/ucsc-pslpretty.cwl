cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslPretty
label: ucsc-pslpretty
doc: "Convert PSL files to a more readable format, showing alignments of the query
  and target sequences.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: psl_file
    type: File
    doc: Input PSL file
    inputBinding:
      position: 1
  - id: target_file
    type: File
    doc: Target sequence file (typically .2bit or .fa)
    inputBinding:
      position: 2
  - id: query_file
    type: File
    doc: Query sequence file (typically .2bit or .fa)
    inputBinding:
      position: 3
  - id: axt
    type:
      - 'null'
      - boolean
    doc: Output in axt format
    inputBinding:
      position: 104
      prefix: -axt
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check that the psl is valid
    inputBinding:
      position: 104
      prefix: -check
  - id: dot
    type:
      - 'null'
      - boolean
    doc: Use dots for matches
    inputBinding:
      position: 104
      prefix: -dot
  - id: long
    type:
      - 'null'
      - boolean
    doc: Use long format
    inputBinding:
      position: 104
      prefix: -long
outputs:
  - id: output_file
    type: File
    doc: Output text file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslpretty:482--h0b57e2e_0
