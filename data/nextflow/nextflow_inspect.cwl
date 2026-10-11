cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nextflow, inspect]
label: nextflow_inspect
doc: "Inspect process settings in a pipeline project.

Tool homepage: https://www.nextflow.io"
inputs:
  - id: project_dir
    type: Directory
    doc: "Project directory with the pipeline script. It is staged in the working directory."
    inputBinding:
      position: 9
      valueFrom: $(self.basename)
  - id: concretize
    type:
      - 'null'
      - boolean
    doc: "Build the container images resolved by the inspect command."
    inputBinding:
      position: 1
      prefix: -concretize
  - id: format
    type:
      - 'null'
      - string
    doc: "Inspect output format, json (default) or config."
    inputBinding:
      position: 2
      prefix: -format
  - id: ignore_errors
    type:
      - 'null'
      - boolean
    doc: "Ignore errors while inspecting the pipeline."
    inputBinding:
      position: 3
      prefix: -ignore-errors
  - id: params_file
    type:
      - 'null'
      - File
    doc: "Load script parameters from a JSON/YAML file."
    inputBinding:
      position: 4
      prefix: -params-file
  - id: profile
    type:
      - 'null'
      - string
    doc: "Use the given configuration profile(s)."
    inputBinding:
      position: 5
      prefix: -profile
  - id: revision
    type:
      - 'null'
      - string
    doc: "Revision of the project to inspect (git branch, tag or commit SHA)."
    inputBinding:
      position: 6
      prefix: -revision
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.project_dir.basename)
        entry: $(inputs.project_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_inspect.out
