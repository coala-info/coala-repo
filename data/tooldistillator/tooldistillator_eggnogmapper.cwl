cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - eggnogmapper
label: tooldistillator_eggnogmapper
doc: "Extract information from output(s) of eggnogmapper (annotations_report.tsv)\n\
  \nTool homepage: https://gitlab.com/ifb-elixirfr/abromics"
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
    doc: eggnogmapper version number for eggnogmapper
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID to eggnogmapper annotation file from Galaxy for 
      eggnogmapper
    inputBinding:
      position: 102
      prefix: --hid
  - id: orthologs_report_hid
    type:
      - 'null'
      - string
    doc: Historic ID to orthologs report file from Galaxy for eggnogmapper
    inputBinding:
      position: 102
      prefix: --orthologs_report_hid
  - id: orthologs_report_path
    type:
      - 'null'
      - File
    doc: Orthologs report file for eggnogmapper
    inputBinding:
      position: 102
      prefix: --orthologs_report_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for eggnogmapper
    inputBinding:
      position: 102
      prefix: --reference_database_version
  - id: seed_orthologs_report_hid
    type:
      - 'null'
      - string
    doc: Historic ID to seed orthologs report file from Galaxy for eggnogmapper
    inputBinding:
      position: 102
      prefix: --seed_orthologs_report_hid
  - id: seed_orthologs_report_path
    type:
      - 'null'
      - File
    doc: Seed orthologs report file for eggnogmapper
    inputBinding:
      position: 102
      prefix: --seed_orthologs_report_path
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
