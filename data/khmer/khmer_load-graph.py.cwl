cwlVersion: v1.2
class: CommandLineTool
baseCommand: khmer_load-graph.py
label: khmer_load-graph.py
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull a Docker image due to insufficient disk space.\n\nTool homepage: https://khmer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
stdout: khmer_load-graph.py.out
