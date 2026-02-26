cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf-pg-loader
  - validate
label: vcf-pg-loader_validate
doc: "Validate a completed load.\n\nTool homepage: https://github.com/Zacharyr41/vcf-pg-loader"
inputs:
  - id: load_batch_id
    type: string
    doc: Load batch UUID to validate
    inputBinding:
      position: 1
  - id: db
    type:
      - 'null'
      - string
    doc: PostgreSQL connection URL
    default: postgresql://localhost/variants
    inputBinding:
      position: 102
      prefix: --db
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf-pg-loader:0.5.4--pyhdfd78af_0
stdout: vcf-pg-loader_validate.out
