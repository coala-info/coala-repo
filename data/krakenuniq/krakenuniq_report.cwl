cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenuniq-report
label: krakenuniq_report
doc: "Make a report with aggregate counts per clade from raw KrakenUniq output files.\n\nTool homepage: https://github.com/fbreitwieser/krakenuniq"
inputs:
  - id: db
    type: Directory
    doc: "Name of the KrakenUniq database"
    inputBinding:
      position: 100
      prefix: --db
  - id: show_zeros
    type:
      - 'null'
      - boolean
    doc: "Show full taxonomy table"
    inputBinding:
      position: 101
      prefix: --show-zeros
  - id: taxon_counts
    type:
      - 'null'
      - boolean
    doc: "Input files are in the format '<taxon ID><tab><count>' instead of Kraken output"
    inputBinding:
      position: 101
      prefix: --taxon-counts
  - id: taxon_list
    type:
      - 'null'
      - boolean
    doc: "Input files is a list of taxon IDs instead of Kraken output"
    inputBinding:
      position: 101
      prefix: --taxon-list
  - id: kraken_files
    type:
      type: array
      items: File
    doc: "KrakenUniq output file(s)"
    inputBinding:
      position: 200
outputs:
  - id: output
    type: stdout
    doc: "Report with aggregate counts per clade"
stdout: krakenuniq_report.tsv
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenuniq:1.0.4--pl5321h668145b_4
