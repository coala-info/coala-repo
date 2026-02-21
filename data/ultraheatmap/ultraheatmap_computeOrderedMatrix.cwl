cwlVersion: v1.2
class: CommandLineTool
baseCommand: ultraheatmap_computeOrderedMatrix
label: ultraheatmap_computeOrderedMatrix
doc: "A tool to compute an ordered matrix for heatmap visualization. (Note: The provided
  help text contains container runtime errors and does not list specific arguments.)\n
  \nTool homepage: https://github.com/maxplanck-ie/ultraheatmap/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ultraheatmap:1.3.1--pyh3252c3a_0
stdout: ultraheatmap_computeOrderedMatrix.out
