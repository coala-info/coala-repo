cwlVersion: v1.2
class: CommandLineTool
baseCommand: emptydrops
label: emptydrops
doc: "A tool for identifying empty droplets in single-cell RNA-seq data.\n\nTool homepage:
  https://pypi.org/project/emptydrops/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emptydrops:0.0.5--py_0
stdout: emptydrops.out
