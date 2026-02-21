cwlVersion: v1.2
class: CommandLineTool
baseCommand: khmer_merge-partition.py
label: khmer_merge-partition.py
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log related to a container runtime (Singularity/Apptainer)
  failing due to insufficient disk space.\n\nTool homepage: https://khmer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
stdout: khmer_merge-partition.py.out
