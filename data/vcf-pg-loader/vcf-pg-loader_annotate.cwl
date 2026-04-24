cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf-pg-loader
  - annotate
label: vcf-pg-loader_annotate
doc: "Annotate loaded variants using reference databases.\n\nTool homepage: https://github.com/Zacharyr41/vcf-pg-loader"
inputs:
  - id: batch_id
    type: string
    doc: Load batch ID of variants to annotate
    inputBinding:
      position: 1
  - id: db
    type:
      - 'null'
      - string
    doc: PostgreSQL URL
    inputBinding:
      position: 102
      prefix: --db
  - id: filter
    type:
      - 'null'
      - string
    doc: Filter expression (echtvar-style)
    inputBinding:
      position: 102
      prefix: --filter
  - id: format
    type:
      - 'null'
      - string
    doc: Output format (tsv, json)
    inputBinding:
      position: 102
      prefix: --format
  - id: limit
    type:
      - 'null'
      - int
    doc: Limit number of results
    inputBinding:
      position: 102
      prefix: --limit
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress non-error output
    inputBinding:
      position: 102
      prefix: --quiet
  - id: source
    type:
      - 'null'
      - string
    doc: Annotation source(s) to use
    inputBinding:
      position: 102
      prefix: --source
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf-pg-loader:0.5.4--pyhdfd78af_0
