cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextflow auth
label: nextflow_auth
doc: "Manage Seqera Platform authentication\n\nTool homepage: https://github.com/nextflow-io/nextflow"
inputs:
  - id: sub_command
    type: string
    doc: Sub-command to execute (login, logout, status, config)
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the sub-command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_auth.out
