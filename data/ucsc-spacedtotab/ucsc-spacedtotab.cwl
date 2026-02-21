cwlVersion: v1.2
class: CommandLineTool
baseCommand: spacedToTab
label: ucsc-spacedtotab
doc: "A tool to convert space-separated files to tab-separated format.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-spacedtotab:482--h0b57e2e_0
stdout: ucsc-spacedtotab.out
