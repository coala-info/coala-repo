cwlVersion: v1.2
class: CommandLineTool
baseCommand: automappa
label: automappa
doc: "Automated mapping and processing of genomic data (Note: The provided text contains
  system error messages and does not include help documentation or argument definitions).\n\
  \nTool homepage: https://github.com/WiscEvan/Automappa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/automappa:2.2.1--pyhdfd78af_0
stdout: automappa.out
