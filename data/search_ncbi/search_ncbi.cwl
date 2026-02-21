cwlVersion: v1.2
class: CommandLineTool
baseCommand: search_ncbi
label: search_ncbi
doc: "A tool for searching NCBI databases. (Note: The provided help text contains
  system error logs and does not list specific arguments or usage instructions.)\n
  \nTool homepage: https://github.com/cyanheads/pubmed-mcp-server"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/search_ncbi:0.1.2--pyhdfd78af_0
stdout: search_ncbi.out
