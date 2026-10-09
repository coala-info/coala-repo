cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenhll-mpa-report
label: krakenhll_mpa_report
doc: "Create a MetaPhlAn-style report (lineage and read count per taxon) from KrakenHLL output files.\n\nTool homepage: https://github.com/fbreitwieser/krakenhll"
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
    doc: Display taxa even if they lack a read in any sample
    inputBinding:
      position: 2
      prefix: --show-zeros
  - id: header_line
    type:
      - 'null'
      - boolean
    doc: Display a header line indicating sample IDs (sample IDs are the filenames)
    inputBinding:
      position: 3
      prefix: --header-line
  - id: intermediate_ranks
    type:
      - 'null'
      - boolean
    doc: Display taxa not at the standard ranks with x__ prefix
    inputBinding:
      position: 4
      prefix: --intermediate-ranks
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
    doc: MetaPhlAn-style report
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenhll:0.4.8--pl5.22.0_0
stdout: krakenhll_mpa_report.txt
