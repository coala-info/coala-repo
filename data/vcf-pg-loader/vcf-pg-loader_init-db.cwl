cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf-pg-loader
  - init-db
label: vcf-pg-loader_init-db
doc: "Initialize database schema.\n\nTool homepage: https://github.com/Zacharyr41/vcf-pg-loader"
inputs:
  - id: db
    type:
      - 'null'
      - string
    doc: PostgreSQL connection URL
    default: postgresql://localhost/various
    inputBinding:
      position: 101
      prefix: --db
  - id: human_genome
    type:
      - 'null'
      - boolean
    doc: Use human chromosome enum type
    inputBinding:
      position: 101
      prefix: --human-genome
  - id: no_human_genome
    type:
      - 'null'
      - boolean
    doc: Use human chromosome enum type
    inputBinding:
      position: 101
      prefix: --no-human-genome
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf-pg-loader:0.5.4--pyhdfd78af_0
stdout: vcf-pg-loader_init-db.out
