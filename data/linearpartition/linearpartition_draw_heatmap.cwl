cwlVersion: v1.2
class: CommandLineTool
baseCommand: linearpartition_draw_heatmap
label: linearpartition_draw_heatmap
doc: "A tool for drawing heatmaps based on LinearPartition results. (Note: The provided
  help text contains only system error messages and no usage information.)\n\nTool
  homepage: https://github.com/LinearFold/LinearPartition"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/linearpartition:1.0.1.dev20240123--h9948957_1
stdout: linearpartition_draw_heatmap.out
