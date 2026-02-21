cwlVersion: v1.2
class: CommandLineTool
baseCommand: gene2xml
label: ncbi-util-legacy_gene2xml
doc: "The provided text does not contain help information for the tool. It contains
  system error messages regarding container execution and disk space.\n\nTool homepage:
  ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-util-legacy:6.1--ha14ba45_0
stdout: ncbi-util-legacy_gene2xml.out
