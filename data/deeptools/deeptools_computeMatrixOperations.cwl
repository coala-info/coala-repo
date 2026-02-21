cwlVersion: v1.2
class: CommandLineTool
baseCommand: computeMatrixOperations
label: deeptools_computeMatrixOperations
doc: "The provided text does not contain help information for the tool. It contains
  system error messages regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/deeptools/deepTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deeptools:3.5.6--pyhdfd78af_0
stdout: deeptools_computeMatrixOperations.out
