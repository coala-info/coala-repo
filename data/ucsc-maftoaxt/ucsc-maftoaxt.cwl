cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafToAxt
label: ucsc-maftoaxt
doc: "A tool to convert MAF (Multiple Alignment Format) files to AXT format. Note:
  The provided help text contains a container execution error and does not list command-line
  arguments.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maftoaxt:482--h0b57e2e_0
stdout: ucsc-maftoaxt.out
