cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nextflow, clone]
label: nextflow_clone
doc: "Clone a project into a folder.

Tool homepage: https://www.nextflow.io"
inputs:
  - id: project_name
    type: string
    doc: "Name of the project to clone, for example nextflow-io/hello."
    inputBinding:
      position: 9
  - id: target_dir
    type:
      - 'null'
      - string
    doc: "Folder to clone into (default: the project name without the owner)."
    inputBinding:
      position: 10
  - id: deep
    type:
      - 'null'
      - int
    doc: "Create a shallow clone of the specified depth."
    inputBinding:
      position: 1
      prefix: -deep
  - id: hub
    type:
      - 'null'
      - string
    doc: "Service hub where the project is hosted."
    inputBinding:
      position: 2
      prefix: -hub
  - id: revision
    type:
      - 'null'
      - string
    doc: "Revision to clone (git branch, tag or revision number)."
    inputBinding:
      position: 3
      prefix: -r
  - id: user
    type:
      - 'null'
      - string
    doc: "Private repository user name."
    inputBinding:
      position: 4
      prefix: -user
outputs:
  - id: cloned
    type: Directory
    doc: The cloned project folder.
    outputBinding:
      glob: |-
        ${ return inputs.target_dir ? inputs.target_dir : inputs.project_name.split('/').pop(); }
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
stdout: nextflow_clone.out
