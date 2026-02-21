cwlVersion: v1.2
class: CommandLineTool
baseCommand: netSyntenic
label: ucsc-netsyntenic
doc: "Add syntenic information to net file. (Note: The provided help text contained
  only container runtime error messages and no usage information; arguments were derived
  from standard tool documentation).\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_net
    type: File
    doc: Input net file
    inputBinding:
      position: 1
outputs:
  - id: out_net
    type: File
    doc: Output net file with synteny information
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-netsyntenic:482--h0b57e2e_0
