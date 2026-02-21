cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypairs
label: pypairs
doc: "A python implementation of the Scialdone et al. (2015) pairs algorithm for single-cell
  gene expression data.\n\nTool homepage: https://github.com/rfechtner/pypairs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypairs:3.2.3--py_0
stdout: pypairs.out
