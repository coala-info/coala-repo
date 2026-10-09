cwlVersion: v1.2
class: CommandLineTool
baseCommand: kraken-report
label: kraken_report
doc: "Create a Kraken report (percent, clade and taxon read counts per taxon) from Kraken output files.\n\nTool homepage: http://ccb.jhu.edu/software/kraken/"
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
    doc: Kraken report
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/kraken:v1.1-3-deb_cv1
stdout: kraken_report.txt
