cwlVersion: v1.2
class: CommandLineTool
baseCommand: netClass
label: ucsc-netclass
doc: "Classify nets in a UCSC net file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: net_file
    type: File
    doc: Input net file
    inputBinding:
      position: 1
outputs:
  - id: out_class
    type: File
    doc: Output classification file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-netclass:482--h0b57e2e_0
