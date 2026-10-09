cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenhll-report
label: krakenhll_report
doc: "Create a report from raw KrakenHLL output (no k-mer counts or coverage). Use krakenhll --report-file for the full report.\n\nTool homepage: https://github.com/fbreitwieser/krakenhll"
inputs:
  - id: db
    type: Directory
    doc: KrakenHLL DB folder (with taxDB, database.kdb and database.idx)
    inputBinding:
      position: 1
      prefix: --db
  - id: show_zeros
    type:
      - 'null'
      - boolean
    doc: Show full taxonomy table
    inputBinding:
      position: 2
      prefix: --show-zeros
  - id: taxon_counts
    type:
      - 'null'
      - boolean
    doc: Input files are in the format '<taxon ID><tab><count>' instead of Kraken output
    inputBinding:
      position: 3
      prefix: --taxon-counts
  - id: taxon_list
    type:
      - 'null'
      - boolean
    doc: Input files are lists of taxon IDs instead of Kraken output
    inputBinding:
      position: 4
      prefix: --taxon-list
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
    doc: Report
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenhll:0.4.8--pl5.22.0_0
stdout: krakenhll_report.txt
