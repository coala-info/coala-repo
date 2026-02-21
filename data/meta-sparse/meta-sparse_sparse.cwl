cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - meta-sparse
  - sparse
label: meta-sparse_sparse
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating a failure to build a container image due to lack of disk space.\n
  \nTool homepage: https://github.com/zheminzhou/SPARSE/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-sparse:0.1.12--py27h24bf2e0_0
stdout: meta-sparse_sparse.out
