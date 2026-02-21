cwlVersion: v1.2
class: CommandLineTool
baseCommand: linearfold_draw_circular_plot
label: linearfold_draw_circular_plot
doc: "A tool for drawing circular plots for LinearFold RNA secondary structure predictions.
  (Note: The provided text contains system error messages regarding container execution
  and does not include usage instructions or argument definitions.)\n\nTool homepage:
  https://github.com/LinearFold/LinearFold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/linearfold:1.0.1.dev20220829--h9948957_2
stdout: linearfold_draw_circular_plot.out
