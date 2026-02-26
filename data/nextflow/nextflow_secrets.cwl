cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextflow secrets
label: nextflow_secrets
doc: "Manage pipeline secrets\n\nTool homepage: https://github.com/nextflow-io/nextflow"
inputs:
  - id: sub_command
    type: string
    doc: The sub-command to execute (delete, get, list, set)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_secrets.out
