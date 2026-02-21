cwlVersion: v1.2
class: CommandLineTool
baseCommand: libis_moabs
label: libis_moabs
doc: "A tool from the MOABS (Model-based Analysis of Bisulfite Sequencing) suite.
  Note: The provided text contains system error logs and does not list specific command-line
  arguments.\n\nTool homepage: https://github.com/Dangertrip/LiBis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libis_moabs:0.0.7--py_0
stdout: libis_moabs.out
