cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - tabular_file
label: tooldistillator_tabular_file
doc: "Extract information from output(s) of tabular_file (report.tsv)\n\nTool homepage:
  https://gitlab.com/ifb-elixirfr/abromics"
inputs:
  - id: report
    type: File
    doc: Path to report(s)
    inputBinding:
      position: 1
  - id: analysis_software_name
    type:
      - 'null'
      - string
    doc: Tool name to the input file for tabular_file
    inputBinding:
      position: 102
      prefix: --analysis_software_name
  - id: analysis_software_version
    type:
      - 'null'
      - string
    doc: Software version to the input file for tabular_file
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID provided by Galaxy for tabular file for tabular_file
    inputBinding:
      position: 102
      prefix: --hid
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for tabular_file
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
