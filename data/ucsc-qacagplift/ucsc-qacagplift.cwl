cwlVersion: v1.2
class: CommandLineTool
baseCommand: qaCagpLift
label: ucsc-qacagplift
doc: "Check that an AGP file and a lift file are consistent.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: agp_file
    type: File
    doc: The AGP file to check.
    inputBinding:
      position: 1
  - id: lift_file
    type: File
    doc: The lift file to check.
    inputBinding:
      position: 2
outputs:
  - id: qa_file
    type: File
    doc: The output QA file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-qacagplift:482--h0b57e2e_0
