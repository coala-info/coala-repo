cwlVersion: v1.2
class: CommandLineTool
baseCommand: drop
label: nextflow_drop
doc: "Delete the local copy of a project\n\nTool homepage: https://github.com/nextflow-io/nextflow"
inputs:
  - id: project_name
    type: string
    doc: name of the project to drop
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Delete the repository without taking care of local changes
    default: false
    inputBinding:
      position: 102
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_drop.out
