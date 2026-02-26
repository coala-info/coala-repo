cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - coverm
label: tooldistillator_coverm
doc: "Extract information from output(s) of coverm (coverage_report.tsv)\n\nTool homepage:
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
    doc: coverm version number for coverm
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: dereplication_cluster_definition_hid
    type:
      - 'null'
      - string
    doc: historic ID for dereplicated representative and member lines file from 
      galaxy for coverm
    inputBinding:
      position: 102
      prefix: --dereplication_cluster_definition_hid
  - id: dereplication_cluster_definition_path
    type:
      - 'null'
      - File
    doc: dereplicated representative and member lines file for coverm
    inputBinding:
      position: 102
      prefix: --dereplication_cluster_definition_path
  - id: dereplication_representative_fasta_zip_hid
    type:
      - 'null'
      - string
    doc: historic ID for representative genome ZIP file from galaxy for coverm
    inputBinding:
      position: 102
      prefix: --dereplication_representative_fasta_zip_hid
  - id: dereplication_representative_fasta_zip_path
    type:
      - 'null'
      - File
    doc: representative genome files in a ZIP file for coverm
    inputBinding:
      position: 102
      prefix: --dereplication_representative_fasta_zip_path
  - id: hid
    type:
      - 'null'
      - string
    doc: historic ID for coverm file from galaxy for coverm
    inputBinding:
      position: 102
      prefix: --hid
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for coverm
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
