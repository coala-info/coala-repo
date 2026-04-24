cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextflow_clean
label: nextflow_clean
doc: "Clean up project cache and work directories\n\nTool homepage: https://github.com/nextflow-io/nextflow"
inputs:
  - id: after
    type:
      - 'null'
      - boolean
    doc: Clean up runs executed after the specified one
    inputBinding:
      position: 101
      prefix: -after
  - id: before
    type:
      - 'null'
      - boolean
    doc: Clean up runs executed before the specified one
    inputBinding:
      position: 101
      prefix: -before
  - id: but
    type:
      - 'null'
      - boolean
    doc: Clean up all runs except the specified one
    inputBinding:
      position: 101
      prefix: -but
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Print names of file to be removed without deleting them
    inputBinding:
      position: 101
      prefix: -dry-run
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force clean command
    inputBinding:
      position: 101
      prefix: -force
  - id: keep_logs
    type:
      - 'null'
      - boolean
    doc: "Removes only temporary files but retains execution log entries and\n   \
      \    metadata"
    inputBinding:
      position: 101
      prefix: -keep-logs
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not print names of files removed
    inputBinding:
      position: 101
      prefix: -quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_clean.out
