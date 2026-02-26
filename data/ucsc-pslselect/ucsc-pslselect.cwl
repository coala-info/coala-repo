cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslSelect
label: ucsc-pslselect
doc: "Select PSL records from a file based on query or target names.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: psl_in
    type: File
    doc: Input PSL file
    inputBinding:
      position: 1
  - id: qt_names
    type:
      - 'null'
      - File
    doc: File with qName tName pairs to select
    inputBinding:
      position: 102
      prefix: -qtNames
  - id: queries
    type:
      - 'null'
      - File
    doc: File with qNames to select
    inputBinding:
      position: 102
      prefix: -queries
  - id: targets
    type:
      - 'null'
      - File
    doc: File with tNames to select
    inputBinding:
      position: 102
      prefix: -targets
outputs:
  - id: psl_out
    type: File
    doc: Output PSL file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslselect:482--h0b57e2e_0
