cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nextflow, log]
label: nextflow_log
doc: "Print executions log and runtime info.

Tool homepage: https://www.nextflow.io"
inputs:
  - id: nextflow_dir
    type: Directory
    doc: "The .nextflow folder of the launch directory (execution history). It is staged in the working directory."
  - id: after
    type:
      - 'null'
      - string
    doc: "Show log entries for runs executed after the specified one."
    inputBinding:
      position: 1
      prefix: -after
  - id: before
    type:
      - 'null'
      - string
    doc: "Show log entries for runs executed before the specified one."
    inputBinding:
      position: 2
      prefix: -before
  - id: but
    type:
      - 'null'
      - string
    doc: "Show log entries of all runs except the specified one."
    inputBinding:
      position: 3
      prefix: -but
  - id: fields
    type:
      - 'null'
      - string
    doc: "Comma separated list of fields to include in the printed log."
    inputBinding:
      position: 4
      prefix: -fields
  - id: filter
    type:
      - 'null'
      - string
    doc: "Filter log entries by a custom expression."
    inputBinding:
      position: 5
      prefix: -filter
  - id: list_fields
    type:
      - 'null'
      - boolean
    doc: "Show all available fields."
    inputBinding:
      position: 6
      prefix: -list-fields
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Show only run names."
    inputBinding:
      position: 7
      prefix: -q
  - id: separator_char
    type:
      - 'null'
      - string
    doc: "Character used to separate column values."
    inputBinding:
      position: 8
      prefix: -s
  - id: template
    type:
      - 'null'
      - string
    doc: "Text template used for each record in the log."
    inputBinding:
      position: 9
      prefix: -template
  - id: run_name_or_session_id
    type:
      - 'null'
      - string
    doc: "Run name or session id."
    inputBinding:
      position: 10
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .nextflow
        entry: $(inputs.nextflow_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_log.out
