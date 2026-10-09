cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenhll-filter
label: krakenhll_filter
doc: "Filter KrakenHLL classifications: reads whose confidence score is below the threshold are moved to a higher taxon.\n\nTool homepage: https://github.com/fbreitwieser/krakenhll"
inputs:
  - id: db
    type: Directory
    doc: KrakenHLL DB folder (with taxDB, database.kdb and database.idx)
    inputBinding:
      position: 1
      prefix: --db
  - id: threshold
    type:
      - 'null'
      - float
    doc: Confidence score threshold between 0 and 1
    inputBinding:
      position: 2
      prefix: --threshold
  - id: kraken_output_files
    type:
      type: array
      items: File
    doc: KrakenHLL output file(s)
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Filtered KrakenHLL output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenhll:0.4.8--pl5.22.0_0
stdout: krakenhll_filter.txt
