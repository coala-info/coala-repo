cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracs_plot-runner.py
label: tracs_plot-runner.py
doc: "The provided text does not contain help information; it consists of error logs
  indicating a failure to build or run a container image due to insufficient disk
  space.\n\nTool homepage: https://github.com/gtonkinhill/tracs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracs:1.0.1--py312h43eeafb_1
stdout: tracs_plot-runner.py.out
