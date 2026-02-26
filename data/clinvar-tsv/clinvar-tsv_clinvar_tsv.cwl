cwlVersion: v1.2
class: CommandLineTool
baseCommand: clinvar-tsv
label: clinvar-tsv_clinvar_tsv
doc: "A tool for processing ClinVar data.\n\nTool homepage: https://github.com/bihealth/clinvar-tsv"
inputs:
  - id: command
    type: string
    doc: 'Subcommand to run: inspect, main, parse_xml, normalize_tsv, merge_tsvs'
    inputBinding:
      position: 1
  - id: inspect
    type:
      - 'null'
      - boolean
    doc: Show files to be created
    inputBinding:
      position: 102
  - id: main
    type:
      - 'null'
      - boolean
    doc: Run the full process pipeline
    inputBinding:
      position: 102
  - id: merge_tsvs
    type:
      - 'null'
      - boolean
    doc: 'Merge TSV file (result: one per VCV)'
    inputBinding:
      position: 102
  - id: normalize_tsv
    type:
      - 'null'
      - boolean
    doc: Parse the Clinvar XML
    inputBinding:
      position: 102
  - id: parse_xml
    type:
      - 'null'
      - boolean
    doc: Parse the Clinvar XML
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clinvar-tsv:0.6.3--pyhdfd78af_0
stdout: clinvar-tsv_clinvar_tsv.out
