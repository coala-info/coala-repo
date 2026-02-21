cwlVersion: v1.2
class: CommandLineTool
baseCommand: ultraheatmap_addFeatureToMatrix
label: ultraheatmap_addFeatureToMatrix
doc: "Add features to a matrix (Note: The provided help text contains only container
  build error logs and no usage information).\n\nTool homepage: https://github.com/maxplanck-ie/ultraheatmap/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ultraheatmap:1.3.1--pyh3252c3a_0
stdout: ultraheatmap_addFeatureToMatrix.out
