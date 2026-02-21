cwlVersion: v1.2
class: CommandLineTool
baseCommand: nquire
label: entrez-direct_nquire
doc: "A tool from the Entrez Direct suite used for constructing and executing Entrez
  queries. Note: The provided help text contains only system error messages regarding
  container execution and does not list specific command-line arguments.\n\nTool homepage:
  https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
stdout: entrez-direct_nquire.out
