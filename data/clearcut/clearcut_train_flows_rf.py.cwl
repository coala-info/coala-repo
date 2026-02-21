cwlVersion: v1.2
class: CommandLineTool
baseCommand: clearcut_train_flows_rf.py
label: clearcut_train_flows_rf.py
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system log messages indicating a failure to build or extract
  a container image due to insufficient disk space.\n\nTool homepage: https://github.com/DavidJBianco/Clearcut"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/clearcut:v1.0.9-3-deb_cv1
stdout: clearcut_train_flows_rf.py.out
