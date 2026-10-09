cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenuniq-filter
label: krakenuniq_filter
doc: "Adjust KrakenUniq output and classifications to require a minimum proportion of k-mers that map to LCAs at or below a given node.\n\nTool homepage: https://github.com/fbreitwieser/krakenuniq"
inputs:
  - id: db
    type:
      - 'null'
      - Directory
    doc: "Name of the KrakenUniq database"
    inputBinding:
      position: 100
      prefix: --db
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Threshold between 0 and 1"
    inputBinding:
      position: 101
      prefix: --threshold
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
    doc: "Filtered KrakenUniq output"
stdout: krakenuniq_filter.kraken
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenuniq:1.0.4--pl5321h668145b_4
