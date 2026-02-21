cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomics-data-index
label: genomics-data-index
doc: "A tool for indexing and querying genomics data. Note: The provided help text
  contains only system error messages and does not list specific command-line arguments.\n
  \nTool homepage: https://github.com/apetkau/genomics-data-index"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
stdout: genomics-data-index.out
