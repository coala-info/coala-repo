cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafToPsl
label: ucsc-maftopsl
doc: "Convert MAF (Multiple Alignment Format) files to PSL (Pattern Space Layout)
  format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maftopsl:482--h0b57e2e_0
stdout: ucsc-maftopsl.out
