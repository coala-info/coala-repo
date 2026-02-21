cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-vdb-py
label: ncbi-vdb-py
doc: "NCBI VDB Python API (Note: The provided text is an error log from a container
  runtime and does not contain usage or help information).\n\nTool homepage: https://github.com/ncbi/ncbi-vdb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-vdb-py:3.2.1--hdfd78af_0
stdout: ncbi-vdb-py.out
