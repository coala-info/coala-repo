cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfClient
label: ucsc-blat_gfClient
doc: "A client for the BLAT (Blast-Like Alignment Tool) server.\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-blat:482--hdc0a859_0
stdout: ucsc-blat_gfClient.out
