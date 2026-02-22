cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylornn_run_predictions_revb.py
label: phylornn_run_predictions_revb.py
doc: "Run predictions using PhyloRNN. (Note: The provided help text contains system
  error messages regarding container image extraction and does not list command-line
  arguments.)\n\nTool homepage: https://github.com/phyloRNN/phyloRNN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylornn:1.1--pyhdfd78af_0
stdout: phylornn_run_predictions_revb.py.out
