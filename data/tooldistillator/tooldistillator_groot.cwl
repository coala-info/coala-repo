cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - groot
label: tooldistillator_groot
doc: "Extract information from output(s) of groot (report.tsv)\n\nTool homepage: https://gitlab.com/ifb-elixirfr/abromics"
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
    doc: groot version for groot
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: bam_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to alignment file from Galaxy for groot
    inputBinding:
      position: 102
      prefix: --bam_file_hid
  - id: bam_file_path
    type:
      - 'null'
      - File
    doc: Binary Alignment file from groot for groot
    inputBinding:
      position: 102
      prefix: --bam_file_path
  - id: groot_log_hid
    type:
      - 'null'
      - string
    doc: historic ID for Groot log file from galaxy for groot
    inputBinding:
      position: 102
      prefix: --groot_log_hid
  - id: groot_log_path
    type:
      - 'null'
      - File
    doc: Groot log file for groot
    inputBinding:
      position: 102
      prefix: --groot_log_path
  - id: hid
    type:
      - 'null'
      - string
    doc: historic ID for groot file from galaxy for groot
    inputBinding:
      position: 102
      prefix: --hid
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for groot
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
