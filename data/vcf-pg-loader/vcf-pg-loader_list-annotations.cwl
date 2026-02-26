cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf-pg-loader
  - list-annotations
label: vcf-pg-loader_list-annotations
doc: "List all loaded annotation sources.\n\nTool homepage: https://github.com/Zacharyr41/vcf-pg-loader"
inputs:
  - id: db
    type:
      - 'null'
      - string
    doc: PostgreSQL URL
    inputBinding:
      position: 101
      prefix: --db
  - id: json
    type:
      - 'null'
      - boolean
    doc: Output as JSON
    inputBinding:
      position: 101
      prefix: --json
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress non-error output
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf-pg-loader:0.5.4--pyhdfd78af_0
stdout: vcf-pg-loader_list-annotations.out
