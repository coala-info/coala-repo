cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextflow_log
label: nextflow_log
doc: "Print executions log and runtime info\n\nTool homepage: https://github.com/nextflow-io/nextflow"
inputs:
  - id: run_name_or_session_id
    type: string
    doc: Run name or session id
    inputBinding:
      position: 1
  - id: after
    type:
      - 'null'
      - boolean
    doc: Show log entries for runs executed after the specified one
    inputBinding:
      position: 102
      prefix: -after
  - id: before
    type:
      - 'null'
      - boolean
    doc: Show log entries for runs executed before the specified one
    inputBinding:
      position: 102
      prefix: -before
  - id: but
    type:
      - 'null'
      - boolean
    doc: Show log entries of all runs except the specified one
    inputBinding:
      position: 102
      prefix: -but
  - id: fields
    type:
      - 'null'
      - string
    doc: "Comma separated list of fields to include in the printed log -- Use the\n\
      \       `-l` option to show the list of available fields"
    inputBinding:
      position: 102
      prefix: -fields
  - id: filter
    type:
      - 'null'
      - string
    doc: "Filter log entries by a custom expression e.g. process =~ /foo.*/ &&\n \
      \      status == 'COMPLETED'"
    inputBinding:
      position: 102
      prefix: -filter
  - id: list_fields
    type:
      - 'null'
      - boolean
    doc: Show all available fields
    inputBinding:
      position: 102
      prefix: -list-fields
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Show only run names
    inputBinding:
      position: 102
      prefix: -quiet
  - id: separator_char
    type:
      - 'null'
      - string
    doc: Character used to separate column values
    inputBinding:
      position: 102
      prefix: -s
  - id: template
    type:
      - 'null'
      - string
    doc: Text template used to each record in the log
    inputBinding:
      position: 102
      prefix: -template
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_log.out
