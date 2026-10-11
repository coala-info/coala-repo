cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nextflow, clean]
label: nextflow_clean
doc: "Clean up project cache and work directories.

Tool homepage: https://www.nextflow.io"
inputs:
  - id: nextflow_dir
    type: Directory
    doc: "The .nextflow folder of the launch directory (execution history and cache). It is staged writable in the working directory."
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: "The work directory of the runs to clean, staged writable as work in the working directory."
  - id: after
    type:
      - 'null'
      - string
    doc: "Clean up runs executed after the specified one."
    inputBinding:
      position: 1
      prefix: -after
  - id: before
    type:
      - 'null'
      - string
    doc: "Clean up runs executed before the specified one."
    inputBinding:
      position: 2
      prefix: -before
  - id: but
    type:
      - 'null'
      - string
    doc: "Clean up all runs except the specified one."
    inputBinding:
      position: 3
      prefix: -but
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: "Print names of files to be removed without deleting them."
    inputBinding:
      position: 4
      prefix: -dry-run
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Force clean command."
    inputBinding:
      position: 5
      prefix: -force
  - id: keep_logs
    type:
      - 'null'
      - boolean
    doc: "Removes only temporary files but retains execution log entries and metadata."
    inputBinding:
      position: 6
      prefix: -keep-logs
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Do not print names of files removed."
    inputBinding:
      position: 7
      prefix: -quiet
  - id: run_name
    type:
      - 'null'
      - string
    doc: "Run name or session id to clean (optional positional)."
    inputBinding:
      position: 8
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
      - entryname: work
        entry: '${ return inputs.work_dir ? inputs.work_dir : null; }'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextflow:25.10.4--h2a3209d_0
stdout: nextflow_clean.out
