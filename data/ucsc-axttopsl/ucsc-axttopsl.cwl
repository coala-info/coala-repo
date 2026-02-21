cwlVersion: v1.2
class: CommandLineTool
baseCommand: axtToPsl
label: ucsc-axttopsl
doc: "Convert axt alignment files to psl format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-axttopsl:482--h0b57e2e_0
stdout: ucsc-axttopsl.out
