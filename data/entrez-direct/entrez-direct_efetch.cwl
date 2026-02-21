cwlVersion: v1.2
class: CommandLineTool
baseCommand: efetch
label: entrez-direct_efetch
doc: "The provided text is an error message indicating a failure to run the container
  (no space left on device) and does not contain the help documentation for the tool.
  As a result, no arguments could be extracted.\n\nTool homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
stdout: entrez-direct_efetch.out
