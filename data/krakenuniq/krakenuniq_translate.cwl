cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenuniq-translate
label: krakenuniq_translate
doc: "For each classified read, print the sequence ID and the full taxonomy.\n\nTool homepage: https://github.com/fbreitwieser/krakenuniq"
inputs:
  - id: db
    type: Directory
    doc: "Name of the KrakenUniq database"
    inputBinding:
      position: 100
      prefix: --db
  - id: mpa_format
    type:
      - 'null'
      - boolean
    doc: "Print the taxonomy in MetaPhlAn format"
    inputBinding:
      position: 101
      prefix: --mpa-format
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
    doc: "Read IDs with their taxonomy"
stdout: krakenuniq_translate.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenuniq:1.0.4--pl5321h668145b_4
