cwlVersion: v1.2
class: CommandLineTool
baseCommand: ultraheatmap
label: ultraheatmap
doc: "A tool for generating and clustering heatmaps (Note: The provided text is an
  error log and does not contain help information).\n\nTool homepage: https://github.com/maxplanck-ie/ultraheatmap/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ultraheatmap:1.3.1--pyh3252c3a_0
stdout: ultraheatmap.out
