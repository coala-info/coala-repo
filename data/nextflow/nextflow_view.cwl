cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nextflow, view]
label: nextflow_view
doc: "View project script file(s).

Tool homepage: https://www.nextflow.io"
inputs:
  - id: project_name
    type: string
    doc: "Name of a downloaded project, for example nextflow-io/hello."
    inputBinding:
      position: 9
  - id: assets_dir
    type:
      - 'null'
      - Directory
    doc: "Folder with the downloaded projects (the .nextflow/assets folder), staged in the working directory."
  - id: hide_header
    type:
      - 'null'
      - boolean
    doc: "Hide header line."
    inputBinding:
      position: 1
      prefix: -q
  - id: list_repo_content
    type:
      - 'null'
      - boolean
    doc: "List repository content."
    inputBinding:
      position: 2
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .nextflow/assets
        entry: '${ return inputs.assets_dir ? inputs.assets_dir : null; }'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_view.out
