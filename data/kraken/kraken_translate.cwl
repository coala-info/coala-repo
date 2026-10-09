cwlVersion: v1.2
class: CommandLineTool
baseCommand: kraken-translate
label: kraken_translate
doc: "Translate the taxon IDs in Kraken output files into taxon names or full lineages.\n\nTool homepage: http://ccb.jhu.edu/software/kraken/"
inputs:
  - id: db
    type: Directory
    doc: Kraken DB folder (with database.kdb, database.idx and taxonomy)
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
    doc: Kraken output file(s)
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: Kraken output with taxon names
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/kraken:v1.1-3-deb_cv1
stdout: kraken_translate.txt
