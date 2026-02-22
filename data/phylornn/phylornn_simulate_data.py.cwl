cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylornn_simulate_data.py
label: phylornn_simulate_data.py
doc: "The provided text contains system error messages (no space left on device) and
  does not include help documentation or usage information for the tool.\n\nTool homepage:
  https://github.com/phyloRNN/phyloRNN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylornn:1.1--pyhdfd78af_0
stdout: phylornn_simulate_data.py.out
