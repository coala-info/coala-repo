cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafAddIRows
label: ucsc-mafaddirows
doc: "The provided text does not contain help information for the tool. It contains
  container runtime logs and a fatal error message.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafaddirows:482--h0b57e2e_0
stdout: ucsc-mafaddirows.out
