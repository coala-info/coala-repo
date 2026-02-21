cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-vdb
label: ncbi-vdb
doc: "No description available: The provided text is an error log regarding container
  image conversion and does not contain tool help information.\n\nTool homepage: https://github.com/ncbi/ncbi-vdb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-vdb:3.3.0--h9948957_0
stdout: ncbi-vdb.out
