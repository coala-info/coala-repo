cwlVersion: v1.2
class: CommandLineTool
baseCommand: nglview
label: nglview
doc: "An IPython/Jupyter widget to interactively view molecular structures and trajectories.\n
  \nTool homepage: https://github.com/arose/nglview"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nglview:1.1.7--py_0
stdout: nglview.out
