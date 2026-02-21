cwlVersion: v1.2
class: CommandLineTool
baseCommand: sc-musketeers
label: sc-musketeers
doc: "A tool for single-cell analysis (Note: The provided text contains container
  build logs rather than tool help text, so specific arguments could not be extracted).\n
  \nTool homepage: https://sc-musketeers.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sc-musketeers:0.4.2--pyhdfd78af_0
stdout: sc-musketeers.out
