cwlVersion: v1.2
class: CommandLineTool
baseCommand: kraken-mpa-report
label: kraken_mpa_report
doc: "Create a MetaPhlAn-style report (lineage and read count per taxon) from Kraken output files.\n\nTool homepage: http://ccb.jhu.edu/software/kraken/"
inputs:
  - id: db
    type: Directory
    doc: Kraken DB folder (with database.kdb, database.idx and taxonomy)
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
    doc: Kraken output file(s)
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
    dockerPull: biocontainers/kraken:v1.1-3-deb_cv1
stdout: kraken_mpa_report.txt
