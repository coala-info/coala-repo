cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextflow_inspect
label: nextflow_inspect
doc: "Inspect process settings in a pipeline project\n\nTool homepage: https://github.com/nextflow-io/nextflow"
inputs:
  - id: project_name_or_url
    type: string
    doc: Project name or repository url
    inputBinding:
      position: 1
  - id: concretize
    type:
      - 'null'
      - boolean
    doc: Build the container images resolved by the inspect command
    inputBinding:
      position: 102
      prefix: -concretize
  - id: format
    type:
      - 'null'
      - string
    doc: Inspect output format. Can be 'json' or 'config'
    inputBinding:
      position: 102
      prefix: -format
  - id: ignore_errors
    type:
      - 'null'
      - boolean
    doc: Ignore errors while inspecting the pipeline
    inputBinding:
      position: 102
      prefix: -ignore-errors
  - id: params_file
    type:
      - 'null'
      - File
    doc: Load script parameters from a JSON/YAML file
    inputBinding:
      position: 102
      prefix: -params-file
  - id: profile
    type:
      - 'null'
      - type: array
        items: string
    doc: Use the given configuration profile(s)
    inputBinding:
      position: 102
      prefix: -profile
  - id: revision
    type:
      - 'null'
      - string
    doc: "Revision of the project to inspect (either a git branch, tag or commit\n\
      \       SHA number)"
    inputBinding:
      position: 102
      prefix: -revision
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_inspect.out
