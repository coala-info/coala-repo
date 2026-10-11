cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nextflow, info]
label: nextflow_info
doc: "Print project and system runtime information.

Tool homepage: https://www.nextflow.io"
inputs:
  - id: project_name
    type:
      - 'null'
      - string
    doc: "Name of a downloaded project, for example nextflow-io/hello (optional). Without it the runtime and system information is printed."
    inputBinding:
      position: 9
  - id: assets_dir
    type:
      - 'null'
      - Directory
    doc: "Folder with the downloaded projects (the .nextflow/assets folder), staged in the working directory."
  - id: check_updates
    type:
      - 'null'
      - boolean
    doc: "Check for remote updates."
    inputBinding:
      position: 1
      prefix: -check-updates
  - id: detailed_info
    type:
      - 'null'
      - boolean
    doc: "Show detailed information."
    inputBinding:
      position: 2
      prefix: -d
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Output format, either text (default), json or yaml. It applies when a project is given."
    inputBinding:
      position: 3
      prefix: -o
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
stdout: nextflow_info.out
