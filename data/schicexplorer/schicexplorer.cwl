cwlVersion: v1.2
class: CommandLineTool
baseCommand: schicexplorer
label: schicexplorer
doc: "A suite of tools for the analysis of single-cell Hi-C data.\n\nTool homepage:
  https://github.com/joachimwolff/scHiCExplorer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
stdout: schicexplorer.out
