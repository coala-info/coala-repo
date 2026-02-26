cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - relecov-tools
  - validate
label: relecov-tools_validate
doc: "Validate json file against schema.\n\nTool homepage: https://github.com/BU-ISCIII/relecov-tools"
inputs:
  - id: check_db
    type:
      - 'null'
      - boolean
    doc: Check if the processed samples are already uploaded to platform 
      database and make invalid those that are already there
    inputBinding:
      position: 101
      prefix: --check_db
  - id: excel_sheet
    type:
      - 'null'
      - string
    doc: 'Optional: Name of the sheet in excel file to validate.'
    inputBinding:
      position: 101
      prefix: --excel_sheet
  - id: json_file
    type: File
    doc: Json file to validate
    inputBinding:
      position: 101
      prefix: --json_file
  - id: json_schema_file
    type: File
    doc: Path to the JSON Schema file used for validation
    inputBinding:
      position: 101
      prefix: --json_schema_file
  - id: logsum_file
    type: File
    doc: Required if --upload_files. Path to the log_summary.json file merged 
      from all previous processes, used to check for invalid samples.
    inputBinding:
      position: 101
      prefix: --logsum_file
  - id: metadata
    type: File
    doc: Origin file containing metadata
    inputBinding:
      position: 101
      prefix: --metadata
  - id: samples_json
    type:
      - 'null'
      - File
    doc: 'Optional: Path to samples_data*.json to auto-detect corrupted files.'
    inputBinding:
      position: 101
      prefix: --samples_json
  - id: upload_files
    type:
      - 'null'
      - boolean
    doc: Wether to upload the resulting files from validation process or not.
    inputBinding:
      position: 101
      prefix: --upload_files
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory where the generated output will be saved
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relecov-tools:1.7.4--pyhdfd78af_0
