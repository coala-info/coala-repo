cwlVersion: v1.2
class: CommandLineTool
baseCommand: brewer2mpl
label: brewer2mpl
doc: "A library for accessing ColorBrewer color maps from Python.\n\nTool homepage:
  https://github.com/conda-forge/brewer2mpl-feedstock"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/brewer2mpl:1.4.1--py35_0
stdout: brewer2mpl.out
