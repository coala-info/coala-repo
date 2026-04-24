cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslSpliceJunctions
label: ucsc-pslsplicejunctions
doc: "Extract splice junctions from PSL files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: psl_in
    type: File
    doc: Input PSL file
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - int
    doc: Set verbosity level
    inputBinding:
      position: 102
      prefix: -verbose
outputs:
  - id: junctions_out
    type: File
    doc: Output junctions file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslsplicejunctions:482--h0b57e2e_0
