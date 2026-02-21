cwlVersion: v1.2
class: CommandLineTool
baseCommand: elink
label: entrez-direct_elink
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime failure (no space left on device).\n
  \nTool homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
stdout: entrez-direct_elink.out
