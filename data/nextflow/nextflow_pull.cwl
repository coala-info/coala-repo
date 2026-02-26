cwlVersion: v1.2
class: CommandLineTool
baseCommand: pull
label: nextflow_pull
doc: "Download or update a project\n\nTool homepage: https://github.com/nextflow-io/nextflow"
inputs:
  - id: project_name_or_url
    type: string
    doc: project name or repository url to pull
    inputBinding:
      position: 1
  - id: deep_clone
    type:
      - 'null'
      - boolean
    doc: Create a shallow clone of the specified depth
    inputBinding:
      position: 102
      prefix: -deep
  - id: private_user_name
    type:
      - 'null'
      - string
    doc: Private repository user name
    inputBinding:
      position: 102
      prefix: -user
  - id: revision
    type:
      - 'null'
      - string
    doc: Revision of the project to run (either a git branch, tag or commit SHA 
      number)
    inputBinding:
      position: 102
      prefix: -revision
  - id: service_hub
    type:
      - 'null'
      - string
    doc: Service hub where the project is hosted
    inputBinding:
      position: 102
      prefix: -hub
  - id: update_all
    type:
      - 'null'
      - boolean
    doc: Update all downloaded projects
    default: false
    inputBinding:
      position: 102
      prefix: -all
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_pull.out
