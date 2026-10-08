cwlVersion: v1.2
class: CommandLineTool
baseCommand: combine_eval_reports.pl
label: eval_combine_eval_reports.pl
doc: "Combines several Eval reports or general statistics reports into one.\n\nTool homepage: http://mblab.wustl.edu/software.html"
inputs:
  - id: eval_report_mode
    type:
      - 'null'
      - boolean
    doc: "Eval report mode (default)"
    inputBinding:
      position: 1
      prefix: -e
  - id: general_stats_mode
    type:
      - 'null'
      - boolean
    doc: "General statistics report mode; cannot be used with -e"
    inputBinding:
      position: 2
      prefix: -s
  - id: reports
    type:
      type: array
      items: File
    doc: "Eval (or general statistics) reports to combine; two or more"
    inputBinding:
      position: 100
outputs:
  - id: stdout
    type: stdout
    doc: Combined report
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eval:2.2.8--pl526_0
stdout: eval_combine_eval_reports.pl.out
