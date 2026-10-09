cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenhll-translate
label: krakenhll_translate
doc: "Translate the taxon IDs in KrakenHLL output files into taxon names or full lineages.\n\nTool homepage: https://github.com/fbreitwieser/krakenhll"
inputs:
  - id: db
    type: Directory
    doc: KrakenHLL DB folder (with taxDB, database.kdb and database.idx)
    inputBinding:
      position: 1
      prefix: --db
  - id: mpa_format
    type:
      - 'null'
      - boolean
    doc: Print the lineage in MetaPhlAn format
    inputBinding:
      position: 2
      prefix: --mpa-format
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
    doc: KrakenHLL output with taxon names
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenhll:0.4.8--pl5.22.0_0
stdout: krakenhll_translate.txt
