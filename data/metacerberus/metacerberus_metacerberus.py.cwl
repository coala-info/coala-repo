cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacerberus.py
label: metacerberus_metacerberus.py
doc: "MetaCerberus is a tool for functional and taxonomy annotation of omics data.
  (Note: The provided text contains system error logs regarding container execution
  and does not list command-line arguments.)\n\nTool homepage: https://github.com/raw-lab/metacerberus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacerberus:1.4.0--pyhdfd78af_1
stdout: metacerberus_metacerberus.py.out
