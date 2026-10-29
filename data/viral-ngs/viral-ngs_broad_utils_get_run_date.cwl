cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - broad_utils.py
  - get_run_date
label: viral-ngs_broad_utils_get_run_date
doc: "Find the sequencing run date from a Picard directory\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_dir
    type: Directory
    doc: "Picard directory"
    inputBinding:
      position: 1
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: ERROR]"
    inputBinding:
      position: 20
      prefix: --loglevel
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_broad_utils_get_run_date.out
