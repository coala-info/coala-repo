cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - checkm2
label: tooldistillator_checkm2
doc: "Extract information from output(s) of checkm2 (quality_report.tsv)\n\nTool homepage:
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
    doc: checkm2 version number for checkm2
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: checkm2_log_hid
    type:
      - 'null'
      - string
    doc: historic ID for Checkm2 log file from galaxy for checkm2
    inputBinding:
      position: 102
      prefix: --checkm2_log_hid
  - id: checkm2_log_path
    type:
      - 'null'
      - File
    doc: Checkm2 log file for checkm2
    inputBinding:
      position: 102
      prefix: --checkm2_log_path
  - id: diamond_results_hid
    type:
      - 'null'
      - string
    doc: historic ID for DIAMOND results file from galaxy for checkm2
    inputBinding:
      position: 102
      prefix: --diamond_results_hid
  - id: diamond_results_path
    type:
      - 'null'
      - File
    doc: DIAMOND_RESULTS file for checkm2
    inputBinding:
      position: 102
      prefix: --diamond_results_path
  - id: hid
    type:
      - 'null'
      - string
    doc: historic ID for checkm2 file from galaxy for checkm2
    inputBinding:
      position: 102
      prefix: --hid
  - id: protein_zip_hid
    type:
      - 'null'
      - string
    doc: historic ID for protein ZIP file from galaxy for checkm2
    inputBinding:
      position: 102
      prefix: --protein_zip_hid
  - id: protein_zip_path
    type:
      - 'null'
      - File
    doc: protein sequence fasta files in a ZIP file for checkm2
    inputBinding:
      position: 102
      prefix: --protein_zip_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for checkm2
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
