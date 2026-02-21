cwlVersion: v1.2
class: CommandLineTool
baseCommand: crTreeSearchBed
label: ucsc-crtreeindexbed_crTreeSearchBed
doc: "Search for items in a crTree index. (Note: The provided help text contains only
  container execution logs and error messages, so no arguments could be extracted.)\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-crtreeindexbed:482--h0b57e2e_0
stdout: ucsc-crtreeindexbed_crTreeSearchBed.out
