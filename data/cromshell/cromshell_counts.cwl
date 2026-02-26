cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cromshell
  - counts
label: cromshell_counts
doc: "Get the summarized statuses of all tasks in the workflow.\n\nTool homepage:
  https://github.com/broadinstitute/cromshell"
inputs:
  - id: workflow_ids
    type:
      type: array
      items: string
    doc: One or more workflow ids belonging to a running workflow separated by a
      space.
    inputBinding:
      position: 1
  - id: compress_subworkflows
    type:
      - 'null'
      - boolean
    doc: Compress sub-workflow metadata information
    inputBinding:
      position: 102
      prefix: --compress-subworkflows
  - id: json_summary
    type:
      - 'null'
      - boolean
    doc: Print a json summary of the task status counts
    inputBinding:
      position: 102
      prefix: --json-summary
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
stdout: cromshell_counts.out
