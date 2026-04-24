cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemini_region
label: gemini_region
doc: "Query regions in a GEMINI database.\n\nTool homepage: https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be queried.
    inputBinding:
      position: 1
  - id: columns
    type:
      - 'null'
      - string
    doc: A list of columns that you would like returned. Def. = "*"
    inputBinding:
      position: 102
      prefix: --columns
  - id: filter
    type:
      - 'null'
      - string
    doc: Restrictions to apply to variants (SQL syntax)
    inputBinding:
      position: 102
      prefix: --filter
  - id: format
    type:
      - 'null'
      - string
    doc: Format of output (JSON, TPED or default)
    inputBinding:
      position: 102
      prefix: --format
  - id: gene
    type:
      - 'null'
      - string
    doc: Specify a gene of interest
    inputBinding:
      position: 102
      prefix: --gene
  - id: header
    type:
      - 'null'
      - boolean
    doc: Add a header of column names to the output.
    inputBinding:
      position: 102
      prefix: --header
  - id: region
    type:
      - 'null'
      - string
    doc: Specify a chromosomal region chr:start-end
    inputBinding:
      position: 102
      prefix: --reg
  - id: show_samples
    type:
      - 'null'
      - boolean
    doc: Add a column of all sample names with a variant to each variant.
    inputBinding:
      position: 102
      prefix: --show-samples
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_region.out
