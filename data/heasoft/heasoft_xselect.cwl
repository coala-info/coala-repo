cwlVersion: v1.2
class: CommandLineTool
baseCommand: xselect
label: heasoft_xselect
doc: "A command-driven cell-based interface for the analysis of X-ray data. (Note:
  The provided text contains system error messages regarding container execution and
  does not include the tool's help documentation.)\n\nTool homepage: https://heasarc.gsfc.nasa.gov/lheasoft/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/heasoft:6.35.2--hedafe93_1
stdout: heasoft_xselect.out
