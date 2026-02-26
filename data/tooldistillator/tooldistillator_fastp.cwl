cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - fastp
label: tooldistillator_fastp
doc: "Extract information from output(s) of fastp (report.json)\n\nTool homepage:
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
    doc: fastp version number for fastp
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: hid
    type:
      - 'null'
      - string
    doc: historic ID for fastp file from galaxy for fastp
    inputBinding:
      position: 102
      prefix: --hid
  - id: html_report_hid
    type:
      - 'null'
      - string
    doc: historic ID for fastp html report for fastp
    inputBinding:
      position: 102
      prefix: --html_report_hid
  - id: html_report_path
    type:
      - 'null'
      - File
    doc: html fastp report path for fastp
    inputBinding:
      position: 102
      prefix: --html_report_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for fastp
    inputBinding:
      position: 102
      prefix: --reference_database_version
  - id: trimmed_forward_r1_hid
    type:
      - 'null'
      - string
    doc: historic ID for forward reads file from galaxy for fastp
    inputBinding:
      position: 102
      prefix: --trimmed_forward_R1_hid
  - id: trimmed_forward_r1_path
    type:
      - 'null'
      - File
    doc: forward R1 trimmed file for fastp
    inputBinding:
      position: 102
      prefix: --trimmed_forward_R1_path
  - id: trimmed_reverse_r2_hid
    type:
      - 'null'
      - string
    doc: historic ID for reverse reads file from galaxy for fastp
    inputBinding:
      position: 102
      prefix: --trimmed_reverse_R2_hid
  - id: trimmed_reverse_r2_path
    type:
      - 'null'
      - File
    doc: reverse R2 trimmed file for fastp
    inputBinding:
      position: 102
      prefix: --trimmed_reverse_R2_path
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
