cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafCheck
label: ucsc-mafaddqrows_mafCheck
doc: "Check MAF (Multiple Alignment Format) files for errors. Note: The provided help
  text contains only container runtime logs and an error message; no specific arguments
  could be extracted.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-mafaddqrows:482--h0b57e2e_0
stdout: ucsc-mafaddqrows_mafCheck.out
