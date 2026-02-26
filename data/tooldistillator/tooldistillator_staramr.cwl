cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - staramr
label: tooldistillator_staramr
doc: "Extract information from output(s) of staramr (resfinder.tsv)\n\nTool homepage:
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
    doc: tool version for staramr
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID provided by Galaxy for resfinder file for staramr
    inputBinding:
      position: 102
      prefix: --hid
  - id: mlst_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID provided by Galaxy for mlst file for staramr
    inputBinding:
      position: 102
      prefix: --mlst_file_hid
  - id: mlst_file_path
    type:
      - 'null'
      - File
    doc: mlst output file from staramr for staramr
    inputBinding:
      position: 102
      prefix: --mlst_file_path
  - id: plasmidfinder_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID provided by Galaxy for plasmid for staramr
    inputBinding:
      position: 102
      prefix: --plasmidfinder_file_hid
  - id: plasmidfinder_file_path
    type:
      - 'null'
      - File
    doc: plasmid output file from staramr for staramr
    inputBinding:
      position: 102
      prefix: --plasmidfinder_file_path
  - id: pointfinder_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID provided by Galaxy for pointfinder for staramr
    inputBinding:
      position: 102
      prefix: --pointfinder_file_hid
  - id: pointfinder_file_path
    type:
      - 'null'
      - File
    doc: pointfinder output file from staramr for staramr
    inputBinding:
      position: 102
      prefix: --pointfinder_file_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for staramr
    inputBinding:
      position: 102
      prefix: --reference_database_version
  - id: setting_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID provided by Galaxy for settings for staramr
    inputBinding:
      position: 102
      prefix: --setting_file_hid
  - id: setting_file_path
    type:
      - 'null'
      - File
    doc: setting file from staramr analysis for staramr
    inputBinding:
      position: 102
      prefix: --setting_file_path
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
