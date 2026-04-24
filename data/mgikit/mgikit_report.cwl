cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mgikit
  - report
label: mgikit_report
doc: "Merge demultipexing reports.\n\nTool homepage: https://sagc-bioinformatics.github.io/mgikit/"
inputs:
  - id: lane
    type:
      - 'null'
      - string
    doc: The lane number, required for report name.
    inputBinding:
      position: 101
      prefix: --lane
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'log level for output messages. Expected values: [error, warn, info, debug,
      trace]. Default is info.'
    inputBinding:
      position: 101
      prefix: --log-level
  - id: prefix
    type:
      - 'null'
      - string
    doc: The prefix of the report. By default, it is the first part of the last 
      input report.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: qc_report
    type:
      type: array
      items: File
    doc: The paths to the QC reports, repeat it for each report.
    inputBinding:
      position: 101
      prefix: --qc-report
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgikit:2.1.1--h3ab6199_0
