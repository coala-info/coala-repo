cwlVersion: v1.2
class: CommandLineTool
baseCommand: wub_plot_counts_correlation
label: wub_plot_counts_correlation
doc: "Plot counts correlation (Note: The provided text is a container build error
  log and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/nanoporetech/wub"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
stdout: wub_plot_counts_correlation.out
