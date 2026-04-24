cwlVersion: v1.2
class: CommandLineTool
baseCommand: srprism
label: srprism_help
doc: "Fast Short Read Aligner\n\nTool homepage: https://github.com/ncbi/SRPRISM"
inputs:
  - id: cmd
    type: string
    doc: 'Action to perform. Possible values are: help, search, mkindex'
    inputBinding:
      position: 1
  - id: log_file
    type:
      - 'null'
      - File
    doc: File for storing diagnostic messages. Default is standard error.
    inputBinding:
      position: 102
      prefix: --log-file
  - id: trace_level
    type:
      - 'null'
      - string
    doc: Minimum message level to report to the log stream. Possible values are 
      "debug", "info", "warning", "error", "quiet".
    inputBinding:
      position: 102
      prefix: --trace-level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srprism:2.4.24--hd6d6fdc_6
stdout: srprism_help.out
