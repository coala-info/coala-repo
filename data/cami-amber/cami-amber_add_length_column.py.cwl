cwlVersion: v1.2
class: CommandLineTool
baseCommand: cami-amber_add_length_column.py
label: cami-amber_add_length_column.py
doc: "The provided text does not contain help information as the execution failed
  due to a system error (no space left on device).\n\nTool homepage: https://github.com/CAMI-challenge/AMBER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cami-amber:2.0.7--pyhdfd78af_0
stdout: cami-amber_add_length_column.py.out
