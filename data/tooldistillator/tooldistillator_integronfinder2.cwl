cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - integronfinder2
label: tooldistillator_integronfinder2
doc: "Extract information from output(s) of integronfinder2 (OUTPUT.integrons, OUTPUT.summary)\n\
  \nTool homepage: https://gitlab.com/ifb-elixirfr/abromics"
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
    doc: integronfinder version for integronfinder2
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: hid
    type:
      - 'null'
      - string
    doc: historic ID for integronfinder file from galaxy for integronfinder2
    inputBinding:
      position: 102
      prefix: --hid
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for integronfinder2
    inputBinding:
      position: 102
      prefix: --reference_database_version
  - id: summary_file_hid
    type:
      - 'null'
      - string
    doc: historic ID for summary file from galaxy for integronfinder2
    inputBinding:
      position: 102
      prefix: --summary_file_hid
  - id: summary_file_path
    type:
      - 'null'
      - File
    doc: integronfinder summary file path for integronfinder2
    inputBinding:
      position: 102
      prefix: --summary_file_path
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
