cwlVersion: v1.2
class: CommandLineTool
baseCommand: rhinotype
label: rhinotype
doc: "A tool for rhinovirus typing (Note: The provided text appears to be a container
  execution log rather than help text; no arguments could be extracted from the input).\n
  \nTool homepage: https://github.com/omicscodeathon/rhinotype"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rhinotype:2.0.0--pyhdfd78af_0
stdout: rhinotype.out
