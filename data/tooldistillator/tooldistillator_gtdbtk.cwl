cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - gtdbtk
label: tooldistillator_gtdbtk
doc: "Extract information from output(s) of gtdbtk (tax_summary.tsv)\n\nTool homepage:
  https://gitlab.com/ifb-elixirfr/abromics"
inputs:
  - id: report
    type: File
    doc: Path to report(s)
    inputBinding:
      position: 1
  - id: align_directory_hid
    type:
      - 'null'
      - string
    doc: Historic ID to align directory from Galaxy for gtdbtk
    inputBinding:
      position: 102
      prefix: --align_directory_hid
  - id: align_directory_path
    type:
      - 'null'
      - Directory
    doc: Align ZIP directory path for gtdbtk
    inputBinding:
      position: 102
      prefix: --align_directory_path
  - id: analysis_software_version
    type:
      - 'null'
      - string
    doc: GTDB-tk version number for gtdbtk
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: classify_directory_hid
    type:
      - 'null'
      - string
    doc: Historic ID to classify directory from Galaxy for gtdbtk
    inputBinding:
      position: 102
      prefix: --classify_directory_hid
  - id: classify_directory_path
    type:
      - 'null'
      - Directory
    doc: Classify ZIP directory path for gtdbtk
    inputBinding:
      position: 102
      prefix: --classify_directory_path
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID to GTDB-tk annotation file from Galaxy for gtdbtk
    inputBinding:
      position: 102
      prefix: --hid
  - id: identify_directory_hid
    type:
      - 'null'
      - string
    doc: Historic ID to identify directory from Galaxy for gtdbtk
    inputBinding:
      position: 102
      prefix: --identify_directory_hid
  - id: identify_directory_path
    type:
      - 'null'
      - Directory
    doc: Identify ZIP directory path for gtdbtk
    inputBinding:
      position: 102
      prefix: --identify_directory_path
  - id: log_file_hid
    type:
      - 'null'
      - string
    doc: Historic ID to log file from Galaxy for gtdbtk
    inputBinding:
      position: 102
      prefix: --log_file_hid
  - id: log_file_path
    type:
      - 'null'
      - File
    doc: Log file path for gtdbtk
    inputBinding:
      position: 102
      prefix: --log_file_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for gtdbtk
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
