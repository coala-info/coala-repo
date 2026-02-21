cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chunked-scatter
  - scatter-regions
label: chunked-scatter_scatter-regions
doc: "A tool for scattering genomic regions into chunks. Note: The provided help text
  contains container execution errors and does not list specific command-line arguments.\n
  \nTool homepage: https://github.com/biowdl/chunked-scatter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chunked-scatter:1.0.0--py_0
stdout: chunked-scatter_scatter-regions.out
