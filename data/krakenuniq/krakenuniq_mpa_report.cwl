cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenuniq-mpa-report
label: krakenuniq_mpa_report
doc: "Make a MetaPhlAn-style report from KrakenUniq output files.\n\nTool homepage: https://github.com/fbreitwieser/krakenuniq"
inputs:
  - id: db
    type:
      - 'null'
      - Directory
    doc: "Name of the KrakenUniq database"
    inputBinding:
      position: 100
      prefix: --db
  - id: show_zeros
    type:
      - 'null'
      - boolean
    doc: "Display taxa even if they lack a read in any sample"
    inputBinding:
      position: 101
      prefix: --show-zeros
  - id: header_line
    type:
      - 'null'
      - boolean
    doc: "Display a header line indicating sample IDs (sample IDs are the filenames)"
    inputBinding:
      position: 101
      prefix: --header-line
  - id: intermediate_ranks
    type:
      - 'null'
      - boolean
    doc: "Display taxa not at the standard ranks with x__ prefix"
    inputBinding:
      position: 101
      prefix: --intermediate-ranks
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
    doc: "MetaPhlAn-style report"
stdout: krakenuniq_mpa_report.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenuniq:1.0.4--pl5321h668145b_4
