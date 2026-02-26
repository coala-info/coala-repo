cwlVersion: v1.2
class: CommandLineTool
baseCommand: gapToLift
label: ucsc-gaptolift
doc: "Convert a gap file to a lift file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: database
    type: string
    doc: The name of the database (e.g., hg18).
    inputBinding:
      position: 1
  - id: gap_file
    type: File
    doc: The input gap file.
    inputBinding:
      position: 2
outputs:
  - id: lift_file
    type: File
    doc: The output lift file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-gaptolift:482--h0b57e2e_0
