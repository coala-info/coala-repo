cwlVersion: v1.2
class: CommandLineTool
baseCommand: scarches
label: scarches
doc: "Single-cell architecture surgery (scArches) is a package for reference-based
  analysis of single-cell data.\n\nTool homepage: https://github.com/theislab/scarches"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scarches:0.6.1--pyh7e72e81_0
stdout: scarches.out
