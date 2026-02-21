cwlVersion: v1.2
class: CommandLineTool
baseCommand: jupyterngsplugin
label: jupyterngsplugin
doc: "A Jupyter plugin for Next-Generation Sequencing (NGS) analysis.\n\nTool homepage:
  https://pypi.org/project/jupyterngsplugin/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jupyterngsplugin:0.0.11a3--py_0
stdout: jupyterngsplugin.out
