cwlVersion: v1.2
class: CommandLineTool
baseCommand: s4pred_run_model.py
label: s4pred_run_model.py
doc: "The provided text does not contain help information for s4pred_run_model.py;
  it appears to be a container build error log.\n\nTool homepage: https://github.com/psipred/s4pred"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/s4pred:1.2.1--pyhdfd78af_1
stdout: s4pred_run_model.py.out
