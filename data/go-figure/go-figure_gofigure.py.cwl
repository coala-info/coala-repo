cwlVersion: v1.2
class: CommandLineTool
baseCommand: go-figure_gofigure.py
label: go-figure_gofigure.py
doc: "A tool for figure generation (Note: The provided help text contains only container
  runtime error messages and no usage information).\n\nTool homepage: https://gitlab.com/evogenlab/GO-Figure"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/go-figure:1.0.2--hdfd78af_0
stdout: go-figure_gofigure.py.out
