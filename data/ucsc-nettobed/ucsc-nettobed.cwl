cwlVersion: v1.2
class: CommandLineTool
baseCommand: netToBed
label: ucsc-nettobed
doc: "Convert net file to BED format. (Note: The provided help text contains only
  container runtime error messages and does not list command-line arguments.)\n\n
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-nettobed:482--h0b57e2e_0
stdout: ucsc-nettobed.out
