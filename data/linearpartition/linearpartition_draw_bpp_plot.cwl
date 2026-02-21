cwlVersion: v1.2
class: CommandLineTool
baseCommand: linearpartition_draw_bpp_plot
label: linearpartition_draw_bpp_plot
doc: "A tool for drawing base pair probability (BPP) plots from LinearPartition output.
  (Note: The provided text contains system error messages and does not list specific
  command-line arguments.)\n\nTool homepage: https://github.com/LinearFold/LinearPartition"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/linearpartition:1.0.1.dev20240123--h9948957_1
stdout: linearpartition_draw_bpp_plot.out
