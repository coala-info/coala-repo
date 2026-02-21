cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-entrez-direct
label: ncbi-entrez-direct
doc: "NCBI Entrez Direct (EDirect) is a suite of command-line tools for searching
  and retrieving data from NCBI's databases. (Note: The provided text contained only
  container runtime error messages and no help documentation; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/tsibley/ncbi-entrez-direct"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ncbi-entrez-direct:v10.9.20190219ds-1b10-deb_cv1
stdout: ncbi-entrez-direct.out
