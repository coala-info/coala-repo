cwlVersion: v1.2
class: CommandLineTool
baseCommand: ddipy_omicsdi
label: ddipy_omicsdi
doc: "A Python tool for interacting with the Omics Discovery Index (OmicsDI). Note:
  The provided help text contains only system error messages regarding container image
  building and does not list specific command-line arguments.\n\nTool homepage: https://github.com/OmicsDI/ddipy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ddipy:0.0.5--py_0
stdout: ddipy_omicsdi.out
