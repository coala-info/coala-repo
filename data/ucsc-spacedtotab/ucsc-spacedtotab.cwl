cwlVersion: v1.2
class: CommandLineTool
baseCommand: spacedToTab
label: ucsc-spacedtotab
doc: "Convert multiple spaces to a single tab.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input
    type: File
    doc: Input space-separated file
    inputBinding:
      position: 1
outputs:
  - id: output
    type: File
    doc: Output tab-separated file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-spacedtotab:482--h0b57e2e_0
