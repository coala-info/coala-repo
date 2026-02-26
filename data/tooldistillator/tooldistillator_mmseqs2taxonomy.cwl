cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tooldistillator.py
  - mmseqs2taxonomy
label: tooldistillator_mmseqs2taxonomy
doc: "Extract information from output(s) of mmseqs2taxonomy (tax_report.tsv)\n\nTool
  homepage: https://gitlab.com/ifb-elixirfr/abromics"
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
    doc: mmseqs2 version number for mmseqs2taxonomy
    inputBinding:
      position: 102
      prefix: --analysis_software_version
  - id: hid
    type:
      - 'null'
      - string
    doc: Historic ID to mmseqs2 taxonomy representative sequence file from 
      Galaxy for mmseqs2taxonomy
    inputBinding:
      position: 102
      prefix: --hid
  - id: kraken_report_hid
    type:
      - 'null'
      - string
    doc: Historic ID to taxonomy Kraken file from Galaxy for mmseqs2taxonomy
    inputBinding:
      position: 102
      prefix: --kraken_report_hid
  - id: kraken_report_path
    type:
      - 'null'
      - File
    doc: Taxonomy report Kraken format for mmseqs2taxonomy
    inputBinding:
      position: 102
      prefix: --kraken_report_path
  - id: krona_report_hid
    type:
      - 'null'
      - string
    doc: Historic ID to taxonomy Krona file from Galaxy for mmseqs2taxonomy
    inputBinding:
      position: 102
      prefix: --krona_report_hid
  - id: krona_report_path
    type:
      - 'null'
      - File
    doc: Taxonomy report Krona format for mmseqs2taxonomy
    inputBinding:
      position: 102
      prefix: --krona_report_path
  - id: reference_database_version
    type:
      - 'null'
      - string
    doc: DB version for mmseqs2taxonomy
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
