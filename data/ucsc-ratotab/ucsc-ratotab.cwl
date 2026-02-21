cwlVersion: v1.2
class: CommandLineTool
baseCommand: raToTab
label: ucsc-ratotab
doc: "The provided text does not contain help information for the tool; it contains
  container runtime error messages. No arguments could be extracted.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-ratotab:482--h0b57e2e_0
stdout: ucsc-ratotab.out
