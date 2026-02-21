cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafMeFirst
label: ucsc-mafmefirst
doc: "Reorder MAF file so that a particular species is first.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafmefirst:482--h0b57e2e_0
stdout: ucsc-mafmefirst.out
