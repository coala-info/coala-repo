cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf-pg-loader
  - load-annotation
label: vcf-pg-loader_load-annotation
doc: "Load an annotation VCF file as a reference database.\nThe annotation source
  can then be used to annotate query VCFs via SQL JOINs.\n\nTool homepage: https://github.com/Zacharyr41/vcf-pg-loader"
inputs:
  - id: vcf_path
    type: File
    doc: Path to annotation VCF file (.vcf, .vcf.gz)
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: JSON field configuration file
    inputBinding:
      position: 102
      prefix: --config
  - id: db
    type:
      - 'null'
      - string
    doc: PostgreSQL URL
    inputBinding:
      position: 102
      prefix: --db
  - id: human_genome
    type:
      - 'null'
      - boolean
    doc: Use human chromosome enum type
    inputBinding:
      position: 102
      prefix: --human-genome
  - id: name
    type:
      - 'null'
      - string
    doc: Name for this annotation source
    inputBinding:
      position: 102
      prefix: --name
  - id: no_human_genome
    type:
      - 'null'
      - boolean
    doc: Use human chromosome enum type
    inputBinding:
      position: 102
      prefix: --no-human-genome
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress non-error output
    inputBinding:
      position: 102
      prefix: --quiet
  - id: type
    type:
      - 'null'
      - string
    doc: Source type (population, pathogenicity, etc.)
    inputBinding:
      position: 102
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf-pg-loader:0.5.4--pyhdfd78af_0
stdout: vcf-pg-loader_load-annotation.out
