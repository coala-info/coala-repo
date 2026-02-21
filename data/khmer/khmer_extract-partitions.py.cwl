cwlVersion: v1.2
class: CommandLineTool
baseCommand: khmer_extract-partitions.py
label: khmer_extract-partitions.py
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build a Singularity/Apptainer container due to insufficient
  disk space.\n\nTool homepage: https://khmer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
stdout: khmer_extract-partitions.py.out
