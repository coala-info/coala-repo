cwlVersion: v1.2
class: CommandLineTool
baseCommand: kraken-filter
label: kraken_filter
doc: "Filter Kraken classifications: reads whose confidence score is below the threshold are moved to a higher taxon.\n\nTool homepage: http://ccb.jhu.edu/software/kraken/"
inputs:
  - id: db
    type: Directory
    doc: Kraken DB folder (with database.kdb, database.idx and taxonomy)
    inputBinding:
      position: 1
      prefix: --db
  - id: threshold
    type:
      - 'null'
      - float
    doc: Confidence score threshold between 0 and 1 (default 0)
    inputBinding:
      position: 2
      prefix: --threshold
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
    doc: Filtered Kraken output with a confidence score column
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/kraken:v1.1-3-deb_cv1
stdout: kraken_filter.txt
