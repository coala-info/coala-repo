cwlVersion: v1.2
class: CommandLineTool
baseCommand: computeMatrix
label: deeptools_computeMatrix
doc: "The provided text contains system error messages and log information regarding
  a container execution failure (no space left on device) rather than the command-line
  help documentation for deeptools_computeMatrix. Consequently, no arguments could
  be extracted.\n\nTool homepage: https://github.com/deeptools/deepTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deeptools:3.5.6--pyhdfd78af_0
stdout: deeptools_computeMatrix.out
