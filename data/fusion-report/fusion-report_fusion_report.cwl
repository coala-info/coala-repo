cwlVersion: v1.2
class: CommandLineTool
baseCommand: fusion_report
label: fusion-report_fusion_report
doc: "Tool for generating friendly UI custom report.\n\nTool homepage: https://github.com/matq007/fusion-report"
inputs:
  - id: command
    type: string
    doc: 'Command to execute: run, download, or sync'
    inputBinding:
      position: 1
  - id: download
    type:
      - 'null'
      - boolean
    doc: Download required databases
    inputBinding:
      position: 102
  - id: run
    type:
      - 'null'
      - boolean
    doc: Run application
    inputBinding:
      position: 102
  - id: sync
    type:
      - 'null'
      - boolean
    doc: Synchronize databases
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fusion-report:4.0.1--py313hdfd78af_0
stdout: fusion-report_fusion_report.out
