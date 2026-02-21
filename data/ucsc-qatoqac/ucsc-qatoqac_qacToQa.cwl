cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - qacToQa
label: ucsc-qatoqac_qacToQa
doc: "The provided text contains container execution logs and a fatal error rather
  than the tool's help documentation. Based on the tool name 'qacToQa', this utility
  is designed to convert .qac files to .qa files.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-qatoqac:482--h0b57e2e_0
stdout: ucsc-qatoqac_qacToQa.out
