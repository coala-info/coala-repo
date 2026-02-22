cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylornn_run_predictions.py
label: phylornn_run_predictions.py
doc: "PhyloRNN prediction tool. (Note: The provided text contains system error messages
  regarding container execution and disk space rather than tool usage instructions.)\n\
  \nTool homepage: https://github.com/phyloRNN/phyloRNN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylornn:1.1--pyhdfd78af_0
stdout: phylornn_run_predictions.py.out
