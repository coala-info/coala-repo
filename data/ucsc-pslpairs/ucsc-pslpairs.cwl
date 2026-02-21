cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslPairs
label: ucsc-pslpairs
doc: "The provided text does not contain help information for the tool. It contains
  container runtime error messages.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslpairs:482--h0b57e2e_0
stdout: ucsc-pslpairs.out
