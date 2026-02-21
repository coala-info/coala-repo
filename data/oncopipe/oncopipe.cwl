cwlVersion: v1.2
class: CommandLineTool
baseCommand: oncopipe
label: oncopipe
doc: "A tool for oncological data analysis pipelines. (Note: The provided text contains
  system error logs and does not list specific command-line arguments.)\n\nTool homepage:
  https://github.com/LCR-BCCRC/lcr-modules"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oncopipe:1.0.12--pyhdfd78af_0
stdout: oncopipe.out
