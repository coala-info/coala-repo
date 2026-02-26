cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cromshell
  - logs
label: cromshell_logs
doc: "Get a subset of the workflow metadata.\n\nTool homepage: https://github.com/broadinstitute/cromshell"
inputs:
  - id: workflow_id
    type: string
    doc: Workflow ID
    inputBinding:
      position: 1
  - id: dont_expand_subworkflows
    type:
      - 'null'
      - boolean
    doc: Do not expand subworkflow info in metadata
    inputBinding:
      position: 102
      prefix: --dont-expand-subworkflows
  - id: print_logs
    type:
      - 'null'
      - boolean
    doc: 'Print the contents of the logs to stdout if true. Note: This assumes GCS
      bucket logs with default permissions otherwise this may not work'
    inputBinding:
      position: 102
      prefix: --print-logs
  - id: status
    type:
      - 'null'
      - string
    doc: Return a list with links to the logs with the indicated status. 
      Separate multiple keys by comma or use 'ALL' to print all logs. Some 
      standard Cromwell status options are 'ALL', 'Done', 'RetryableFailure', 
      'Running', and 'Failed'.
    inputBinding:
      position: 102
      prefix: --status
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
stdout: cromshell_logs.out
