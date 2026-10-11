cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nextflow, pull]
label: nextflow_pull
doc: "Download or update a project. The project is stored in .nextflow/assets of the working directory.

Tool homepage: https://www.nextflow.io"
inputs:
  - id: project_name_or_url
    type: string
    doc: "Project name (for example nextflow-io/hello) or repository URL to pull."
    inputBinding:
      position: 9
  - id: update_all
    type:
      - 'null'
      - boolean
    doc: "Update all downloaded projects."
    inputBinding:
      position: 1
      prefix: -all
  - id: deep
    type:
      - 'null'
      - int
    doc: "Create a shallow clone of the specified depth."
    inputBinding:
      position: 2
      prefix: -deep
  - id: hub
    type:
      - 'null'
      - string
    doc: "Service hub where the project is hosted."
    inputBinding:
      position: 3
      prefix: -hub
  - id: revision
    type:
      - 'null'
      - string
    doc: "Revision of the project (git branch, tag or commit SHA)."
    inputBinding:
      position: 4
      prefix: -revision
  - id: user
    type:
      - 'null'
      - string
    doc: "Private repository user name."
    inputBinding:
      position: 5
      prefix: -user
outputs:
  - id: assets
    type: Directory
    doc: Folder with the downloaded projects.
    outputBinding:
      glob: .nextflow/assets
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_pull.out
