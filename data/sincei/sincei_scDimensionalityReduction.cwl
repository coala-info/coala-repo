cwlVersion: v1.2
class: CommandLineTool
baseCommand: sincei_scDimensionalityReduction
label: sincei_scDimensionalityReduction
doc: "Dimensionality reduction for single-cell data (Note: The provided text contains
  container runtime error logs rather than tool help text, so no arguments could be
  extracted).\n\nTool homepage: https://github.com/bhardwaj-lab/sincei"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sincei:0.5.2--pyhdfd78af_0
stdout: sincei_scDimensionalityReduction.out
