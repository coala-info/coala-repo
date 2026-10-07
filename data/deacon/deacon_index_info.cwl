cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deacon
  - index
  - info
label: deacon_index_info
doc: "Show index information\n\nTool homepage: https://github.com/bede/deacon"
inputs:
  - id: index
    type: File
    doc: Path to index file
    inputBinding:
      position: 1
outputs:
  - id: info
    type: stdout
    doc: Index information
  - id: log
    type: stderr
    doc: Index information written to standard error
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
stdout: deacon_index_info.out
stderr: deacon_index_info.err
