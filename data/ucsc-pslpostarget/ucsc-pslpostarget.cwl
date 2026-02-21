cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslPosTarget
label: ucsc-pslpostarget
doc: "Set target position in psl to be the same as query position.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: psl_in
    type: File
    doc: Input PSL file
    inputBinding:
      position: 1
outputs:
  - id: psl_out
    type: File
    doc: Output PSL file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslpostarget:482--h0b57e2e_0
