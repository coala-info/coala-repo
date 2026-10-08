cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - funnel
  - storage
  - stat-task
label: funnel_storage_stat-task
doc: "Returns information about inputs/outputs of the task.\n\nTool homepage: https://ohsu-comp-bio.github.io/funnel/"
inputs:
  - id: task_file
    type: File
    doc: Task file (JSON)
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: Config File
    inputBinding:
      position: 0
      prefix: --config
  - id: local_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Local files that the URL refers to (staged in the working directory, so
      a relative file URL resolves)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.local_files || [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/funnel:0.9.0--0
stdout: funnel_storage_stat-task.out
