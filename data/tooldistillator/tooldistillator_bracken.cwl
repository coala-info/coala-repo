cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - bracken
label: tooldistillator_bracken
doc: "Extract information from output(s) of bracken (report.tsv)\n\nTool homepage:
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
    doc: bracken version for bracken
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID to kraken report file from Galaxy for bracken
    inputBinding:
      position: 102
      prefix: --hid
  - id: kraken_report_hid
    type:
      - 'null'
      - string
    doc: Historic ID to kraken results file from Galaxy for bracken
    inputBinding:
      position: 102
      prefix: --kraken_report_hid
  - id: kraken_report_path
    type:
      - 'null'
      - File
    doc: New kraken report estimated from bracken for bracken
    inputBinding:
      position: 102
      prefix: --kraken_report_path
  - id: level
    type:
      - 'null'
      - string
    doc: level to estimate abundance for bracken
    inputBinding:
      position: 102
      prefix: --level
  - id: read_len
    type:
      - 'null'
      - int
    doc: read length value for bracken
    inputBinding:
      position: 102
      prefix: --read_len
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: bracken DB version for bracken
    inputBinding:
      position: 102
      prefix: --reference_database_version
  - id: threshold
    type:
      - 'null'
      - int
    doc: number of reads required PRIOR to abundance estimation for bracken
    inputBinding:
      position: 102
      prefix: --threshold
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
