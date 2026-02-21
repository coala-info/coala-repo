cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5sparse
label: h5sparse
doc: "Scipy sparse matrix in HDF5\n\nTool homepage: https://github.com/appier/h5sparse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/h5sparse:0.1.0--pyh086e186_0
stdout: h5sparse.out
