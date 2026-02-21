cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgap
label: fgap
doc: "A tool for filling gaps in genome assemblies (Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  tool arguments).\n\nTool homepage: https://github.com/pirovc/fgap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgap:1.8.1--hdfd78af_2
stdout: fgap.out
