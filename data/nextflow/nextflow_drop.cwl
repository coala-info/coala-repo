cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nextflow, drop]
label: nextflow_drop
doc: "Delete the local copy of a project.

Tool homepage: https://www.nextflow.io"
inputs:
  - id: project_name
    type: string
    doc: "Name of the project to drop, for example nextflow-io/hello."
    inputBinding:
      position: 9
  - id: assets_dir
    type: Directory
    doc: "Folder with the downloaded projects (the .nextflow/assets folder), staged writable in the working directory."
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Delete the repository without taking care of local changes."
    inputBinding:
      position: 1
      prefix: -f
outputs:
  - id: assets_after
    type: Directory
    doc: The folder with the downloaded projects after the drop.
    outputBinding:
      glob: .nextflow/assets
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .nextflow/assets
        entry: $(inputs.assets_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_drop.out
