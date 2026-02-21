cwlVersion: v1.2
class: CommandLineTool
baseCommand: khmer_load-into-counting.py
label: khmer_load-into-counting.py
doc: "The provided text does not contain help documentation for the tool. It contains
  system logs and a fatal error message indicating a failure to build the container
  image due to lack of disk space.\n\nTool homepage: https://khmer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
stdout: khmer_load-into-counting.py.out
