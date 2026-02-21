cwlVersion: v1.2
class: CommandLineTool
baseCommand: scree_plot_pyseer
label: pyseer_scree_plot_pyseer
doc: "Scree plot for pyseer (Note: The provided help text contains only container
  runtime error logs and does not list specific arguments).\n\nTool homepage: https://github.com/mgalardini/pyseer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyseer:1.4.0--pyhdfd78af_0
stdout: pyseer_scree_plot_pyseer.out
