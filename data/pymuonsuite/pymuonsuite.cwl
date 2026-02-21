cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymuonsuite
label: pymuonsuite
doc: "A suite of tools for muon spectroscopy data analysis.\n\nTool homepage: https://github.com/conda-forge/pymuonsuite-feedstock"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymuonsuite:0.3.0
stdout: pymuonsuite.out
