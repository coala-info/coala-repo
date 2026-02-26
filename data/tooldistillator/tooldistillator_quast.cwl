cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - quast
label: tooldistillator_quast
doc: "Extract information from output(s) of quast (report.tsv)\n\nTool homepage: https://gitlab.com/ifb-elixirfr/abromics"
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
    doc: Quast version number for quast
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID to quast file from Galaxy for quast
    inputBinding:
      position: 102
      prefix: --hid
  - id: quast_html_hid
    type:
      - 'null'
      - string
    doc: Historic ID to quast html file from Galaxy for quast
    inputBinding:
      position: 102
      prefix: --quast_html_hid
  - id: quast_html_path
    type:
      - 'null'
      - File
    doc: Quast html report file for quast
    inputBinding:
      position: 102
      prefix: --quast_html_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for quast
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
