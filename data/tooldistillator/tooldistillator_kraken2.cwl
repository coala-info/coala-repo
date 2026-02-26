cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - kraken2
label: tooldistillator_kraken2
doc: "Extract information from output(s) of kraken2 (report.tsv)\n\nTool homepage:
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
    doc: kraken2 version for kraken2
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: hid
    type:
      - 'null'
      - string
    doc: kraken report hid for kraken2
    inputBinding:
      position: 102
      prefix: --hid
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: kraken2 DB version for kraken2
    inputBinding:
      position: 102
      prefix: --reference_database_version
  - id: seq_classification_file_hid
    type:
      - 'null'
      - string
    doc: historic ID for read classification file from Galaxy for kraken2
    inputBinding:
      position: 102
      prefix: --seq_classification_file_hid
  - id: seq_classification_file_path
    type:
      - 'null'
      - File
    doc: file containing the classification of each reads for kraken2
    inputBinding:
      position: 102
      prefix: --seq_classification_file_path
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
