cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslToBed
label: ucsc-psltobed
doc: "A UCSC utility to convert PSL (Pattern Space Layout) files to BED format.\n\n
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-psltobed:482--h0b57e2e_0
stdout: ucsc-psltobed.out
