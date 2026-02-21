cwlVersion: v1.2
class: CommandLineTool
baseCommand: efilter
label: entrez-direct_efilter
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build a container image due to
  insufficient disk space ('no space left on device').\n\nTool homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/entrez-direct:24.0--he881be0_0
stdout: entrez-direct_efilter.out
