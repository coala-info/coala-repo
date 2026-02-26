cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - fastqc
label: tooldistillator_fastqc
doc: "Extract information from output(s) of fastqc (report.txt)\n\nTool homepage:
  https://gitlab.com/ifb-elixirfr/abromics"
inputs:
  - id: report
    type: File
    doc: Path to report(s)
    inputBinding:
      position: 1
  - id: analysis_software_version
    type:
      - 'null'
      - string
    doc: fastqc version number for fastqc
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: hid
    type:
      - 'null'
      - string
    doc: historic ID for fastqc file from galaxy for fastqc
    inputBinding:
      position: 102
      prefix: --hid
  - id: html_report_hid
    type:
      - 'null'
      - string
    doc: historic ID for fastqc html report for fastqc
    inputBinding:
      position: 102
      prefix: --html_report_hid
  - id: html_report_path
    type:
      - 'null'
      - File
    doc: html fastqc report path for fastqc
    inputBinding:
      position: 102
      prefix: --html_report_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for fastqc
    inputBinding:
      position: 102
      prefix: --reference_database_version
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output location
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tooldistillator:1.0.5--pyh7e72e81_0
