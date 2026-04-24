cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextflow_info
label: nextflow_info
doc: "Print project and system runtime information\n\nTool homepage: https://github.com/nextflow-io/nextflow"
inputs:
  - id: project_name
    type: string
    doc: project name
    inputBinding:
      position: 1
  - id: check_updates
    type:
      - 'null'
      - boolean
    doc: Check for remote updates
    inputBinding:
      position: 102
      prefix: -check-updates
  - id: detailed_info
    type:
      - 'null'
      - boolean
    doc: Show detailed information
    inputBinding:
      position: 102
      prefix: -d
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output format, either: text (default), json, yaml'
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_info.out
