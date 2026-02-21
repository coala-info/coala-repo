cwlVersion: v1.2
class: CommandLineTool
baseCommand: entrez-direct
label: entrez-direct
doc: "Entrez Direct (EDirect) is a suite of command-line tools that provide access
  to the NCBI's Entrez databases.\n\nTool homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
stdout: entrez-direct.out
