cwlVersion: v1.2
class: CommandLineTool
baseCommand: dagchainer_run_XYplot.pl
label: dagchainer_run_XYplot.pl
doc: "A script to generate XY plots for DAGchainer results. (Note: The provided help
  text contains system error messages and does not list specific command-line arguments).\n
  \nTool homepage: https://github.com/kullrich/dagchainer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dagchainer:r120920--h9948957_5
stdout: dagchainer_run_XYplot.pl.out
