cwlVersion: v1.2
class: CommandLineTool
baseCommand: ra-integrate
label: ra-integrate
doc: "A tool for integrating genomic data (Note: The provided text is a container
  runtime error log and does not contain usage information or argument definitions).\n
  \nTool homepage: https://github.com/mediavrog/integrated-rating-request"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ra-integrate:0.1--0
stdout: ra-integrate.out
