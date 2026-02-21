cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacerberus
label: metacerberus
doc: "MetaCerberus is a tool for automated metagenomic and multi-omic search and visualization.
  (Note: The provided text contains system error logs regarding a container runtime
  failure and does not include the actual help documentation or argument list).\n\n
  Tool homepage: https://github.com/raw-lab/metacerberus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacerberus:1.4.0--pyhdfd78af_1
stdout: metacerberus.out
