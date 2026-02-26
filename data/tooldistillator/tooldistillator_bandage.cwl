cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - bandage
label: tooldistillator_bandage
doc: "Extract information from output(s) of bandage (OUTPUT.txt)\n\nTool homepage:
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
    doc: bandage version number for bandage
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: bandage_plot_hid
    type:
      - 'null'
      - string
    doc: historic ID for bandage plot from galaxy for bandage
    inputBinding:
      position: 102
      prefix: --bandage_plot_hid
  - id: bandage_plot_path
    type:
      - 'null'
      - File
    doc: bandage plot file for bandage
    inputBinding:
      position: 102
      prefix: --bandage_plot_path
  - id: hid
    type:
      - 'null'
      - string
    doc: historic ID for bandage file from galaxy for bandage
    inputBinding:
      position: 102
      prefix: --hid
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for bandage
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
