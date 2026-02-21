cwlVersion: v1.2
class: CommandLineTool
baseCommand: fusion-report
label: fusion-report_fusion_report
doc: "A tool for generating reports on gene fusions. (Note: The provided help text
  contains only system error logs and does not list specific command-line arguments.)\n
  \nTool homepage: https://github.com/matq007/fusion-report"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fusion-report:4.0.1--py313hdfd78af_0
stdout: fusion-report_fusion_report.out
