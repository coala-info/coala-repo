cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextflow_view
label: nextflow_view
doc: "View project script file(s)\n\nTool homepage: https://github.com/nextflow-io/nextflow"
inputs:
  - id: project_name
    type: string
    doc: project name
    inputBinding:
      position: 1
  - id: hide_header
    type:
      - 'null'
      - boolean
    doc: Hide header line
    inputBinding:
      position: 102
      prefix: -q
  - id: list_repo_content
    type:
      - 'null'
      - boolean
    doc: List repository content
    inputBinding:
      position: 102
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_view.out
