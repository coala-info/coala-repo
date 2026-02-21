cwlVersion: v1.2
class: CommandLineTool
baseCommand: clearcut_train_flows_iforest.py
label: clearcut_train_flows_iforest.py
doc: "The provided text does not contain help documentation or usage instructions;
  it contains system error messages regarding a container build failure (no space
  left on device).\n\nTool homepage: https://github.com/DavidJBianco/Clearcut"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/clearcut:v1.0.9-3-deb_cv1
stdout: clearcut_train_flows_iforest.py.out
