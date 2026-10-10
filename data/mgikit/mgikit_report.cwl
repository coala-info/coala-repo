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
      inputBinding:
        prefix: --qc-report
    doc: The paths to the QC reports (the .sample_stats files written by demultiplex),
      one --qc-report per report.
    inputBinding:
      position: 101
  - id: output_path
    type: string
    default: report_out/merged
    doc: The path and prefix of the output files. The tool creates two files with this
      prefix, ending in .info and .general.
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Merged report files (<prefix>.info and <prefix>.general)
    outputBinding:
      glob: $(inputs.output_path).*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mgikit:2.1.1--h3ab6199_0
