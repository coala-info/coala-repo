cwlVersion: v1.2
class: CommandLineTool
baseCommand: esearch
label: entrez-direct_esearch
doc: "Search Entrez databases. (Note: The provided input text contains system error
  messages regarding container execution and does not include the actual help documentation
  for the tool.)\n\nTool homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
stdout: entrez-direct_esearch.out
