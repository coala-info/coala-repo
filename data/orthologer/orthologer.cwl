cwlVersion: v1.2
class: CommandLineTool
baseCommand: orthologer
label: orthologer
doc: "The provided text is a system error log regarding a container execution failure
  and does not contain help information or argument definitions for the tool.\n\n
  Tool homepage: https://orthologer.ezlab.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orthologer:3.9.0--py312hf097cbd_0
stdout: orthologer.out
