cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - abricate
label: tooldistillator_abricate
doc: "Extract information from output(s) of abricate (OUTPUT.tsv)\n\nTool homepage:
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
    doc: abricate version for abricate
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: hid
    type:
      - 'null'
      - string
    doc: historic ID for abricate file from galaxy for abricate
    inputBinding:
      position: 102
      prefix: --hid
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for abricate
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
