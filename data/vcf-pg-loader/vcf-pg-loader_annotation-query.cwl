cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf-pg-loader
  - annotation-query
label: vcf-pg-loader_annotation-query
doc: "Execute an ad-hoc SQL query against annotation tables.\n\nTool homepage: https://github.com/Zacharyr41/vcf-pg-loader"
inputs:
  - id: db
    type:
      - 'null'
      - string
    doc: PostgreSQL URL
    inputBinding:
      position: 101
      prefix: --db
  - id: format
    type:
      - 'null'
      - string
    doc: Output format (tsv, json)
    default: tsv
    inputBinding:
      position: 101
      prefix: --format
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress non-error output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: sql
    type: string
    doc: SQL query to execute
    inputBinding:
      position: 101
      prefix: --sql
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf-pg-loader:0.5.4--pyhdfd78af_0
stdout: vcf-pg-loader_annotation-query.out
