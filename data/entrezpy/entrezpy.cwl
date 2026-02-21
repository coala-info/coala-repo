cwlVersion: v1.2
class: CommandLineTool
baseCommand: entrezpy
label: entrezpy
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build a container image due to
  insufficient disk space.\n\nTool homepage: https://gitlab.com/ncbipy/entrezpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/entrezpy:2.1.3--pyh5e36f6f_0
stdout: entrezpy.out
