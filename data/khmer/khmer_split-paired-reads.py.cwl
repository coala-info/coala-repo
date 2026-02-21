cwlVersion: v1.2
class: CommandLineTool
baseCommand: khmer_split-paired-reads.py
label: khmer_split-paired-reads.py
doc: "The provided text does not contain help information as the tool failed to execute
  due to a system error (no space left on device).\n\nTool homepage: https://khmer.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
stdout: khmer_split-paired-reads.py.out
