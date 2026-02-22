cwlVersion: v1.2
class: CommandLineTool
baseCommand: breakfast
label: breakfast
doc: "A tool for detecting genomic structural variants (Note: The provided text contains
  only system error messages and no CLI usage information).\n\nTool homepage: https://github.com/rki-mf1/breakfast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/breakfast:0.4.6--pyhdfd78af_0
stdout: breakfast.out
