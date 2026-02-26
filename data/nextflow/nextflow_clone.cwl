cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextflow_clone
label: nextflow_clone
doc: "Clone a project into a folder\n\nTool homepage: https://github.com/nextflow-io/nextflow"
inputs:
  - id: project_name
    type: string
    doc: name of the project to clone
    inputBinding:
      position: 1
  - id: hub
    type:
      - 'null'
      - string
    doc: Service hub where the project is hosted
    inputBinding:
      position: 102
      prefix: -hub
  - id: revision
    type:
      - 'null'
      - string
    doc: Revision to clone - It can be a git branch, tag or revision number
    inputBinding:
      position: 102
      prefix: -r
  - id: shallow_clone
    type:
      - 'null'
      - boolean
    doc: Create a shallow clone of the specified depth
    inputBinding:
      position: 102
      prefix: -deep
  - id: user
    type:
      - 'null'
      - string
    doc: Private repository user name
    inputBinding:
      position: 102
      prefix: -user
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_clone.out
