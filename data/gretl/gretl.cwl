cwlVersion: v1.2
class: CommandLineTool
baseCommand: gretl
label: gretl
doc: "Gnu Regression, Econometrics and Time-series Library (Note: The provided text
  contains container runtime errors and does not list specific tool arguments or help
  information).\n\nTool homepage: https://github.com/moinsebi/gretl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gretl:0.1.1--hc1c3326_2
stdout: gretl.out
