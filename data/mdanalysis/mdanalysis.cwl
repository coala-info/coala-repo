cwlVersion: v1.2
class: CommandLineTool
baseCommand: mdanalysis
label: mdanalysis
doc: "MDAnalysis is a Python library for the analysis of computer simulations of many-body
  systems at the molecular scale.\n\nTool homepage: https://github.com/MDAnalysis/mdanalysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mdanalysis:1.0.0
stdout: mdanalysis.out
