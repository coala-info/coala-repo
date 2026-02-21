cwlVersion: v1.2
class: CommandLineTool
baseCommand: arboreto_with_dask.py
label: arboreto_arboreto_with_dask.py
doc: "Arboreto: a scalable framework for gene regulatory network inference using Dask.\n
  \nTool homepage: https://github.com/tmoerman/arboreto"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arboreto:0.1.6--pyh7e72e81_1
stdout: arboreto_arboreto_with_dask.py.out
