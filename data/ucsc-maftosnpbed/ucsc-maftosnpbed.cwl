cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafToSnpBed
label: ucsc-maftosnpbed
doc: "A tool to convert MAF (Multiple Alignment Format) files to SNP BED format. Note:
  The provided help text contains only system error logs and does not list specific
  arguments.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maftosnpbed:482--h0b57e2e_0
stdout: ucsc-maftosnpbed.out
