cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacerberus.py
label: metacerberus-lite_metacerberus.py
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime failure (no space left
  on device).\n\nTool homepage: https://github.com/raw-lab/metacerberus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacerberus-lite:1.4.0--pyhdfd78af_1
stdout: metacerberus-lite_metacerberus.py.out
