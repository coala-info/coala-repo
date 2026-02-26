cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - sylphtax
label: tooldistillator_sylphtax
doc: "Extract information from output(s) of sylphtax (merge_report.tsv)\n\nTool homepage:
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
    doc: sylph-tax version number for sylphtax
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: hid
    type:
      - 'null'
      - string
    doc: historic ID for sylph-tax file from galaxy for sylphtax
    inputBinding:
      position: 102
      prefix: --hid
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for sylphtax
    inputBinding:
      position: 102
      prefix: --reference_database_version
  - id: taxonomic_profile_folder_hid
    type:
      - 'null'
      - string
    doc: Historic ID to taxonomic profile folder from Galaxy for sylphtax
    inputBinding:
      position: 102
      prefix: --taxonomic_profile_folder_hid
  - id: taxonomic_profile_folder_path
    type:
      - 'null'
      - Directory
    doc: Taxonomic profile folder for sylph-tax for sylphtax
    inputBinding:
      position: 102
      prefix: --taxonomic_profile_folder_path
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
