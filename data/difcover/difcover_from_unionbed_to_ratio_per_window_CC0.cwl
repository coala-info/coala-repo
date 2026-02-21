cwlVersion: v1.2
class: CommandLineTool
baseCommand: difcover_from_unionbed_to_ratio_per_window_CC0
label: difcover_from_unionbed_to_ratio_per_window_CC0
doc: "A tool to calculate ratios per window from unionbed files. (Note: The provided
  help text contains only system error messages regarding container execution and
  does not list specific command-line arguments.)\n\nTool homepage: https://github.com/timnat/DifCover"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/difcover:3.0.1--h9948957_2
stdout: difcover_from_unionbed_to_ratio_per_window_CC0.out
