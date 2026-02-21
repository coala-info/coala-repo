cwlVersion: v1.2
class: CommandLineTool
baseCommand: fusion-report
label: fusion-report
doc: "A tool for parsing and reporting fusion genes (Note: The provided help text
  contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/matq007/fusion-report"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fusion-report:4.0.1--py313hdfd78af_0
stdout: fusion-report.out
