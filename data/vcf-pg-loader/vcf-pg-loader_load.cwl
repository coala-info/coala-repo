cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf-pg-loader
  - load
label: vcf-pg-loader_load
doc: "Load a VCF file into PostgreSQL.\n\nTool homepage: https://github.com/Zacharyr41/vcf-pg-loader"
inputs:
  - id: vcf_path
    type: File
    doc: Path to VCF file (.vcf, .vcf.gz)
    inputBinding:
      position: 1
  - id: batch
    type:
      - 'null'
      - int
    doc: Records per batch
    inputBinding:
      position: 102
      prefix: --batch
  - id: config
    type:
      - 'null'
      - File
    doc: TOML configuration file
    inputBinding:
      position: 102
      prefix: --config
  - id: database
    type:
      - 'null'
      - string
    doc: Database name
    inputBinding:
      position: 102
      prefix: --database
  - id: db
    type:
      - 'null'
      - string
    doc: PostgreSQL URL ('auto' for managed DB, omit to auto-detect)
    inputBinding:
      position: 102
      prefix: --db
  - id: drop_indexes
    type:
      - 'null'
      - boolean
    doc: Drop indexes during load
    inputBinding:
      position: 102
      prefix: --drop-indexes
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force reload even if file was already loaded
    inputBinding:
      position: 102
      prefix: --force
  - id: host
    type:
      - 'null'
      - string
    doc: PostgreSQL host
    inputBinding:
      position: 102
      prefix: --host
  - id: human_genome
    type:
      - 'null'
      - boolean
    doc: Use human chromosome enum type
    inputBinding:
      position: 102
      prefix: --human-genome
  - id: keep_indexes
    type:
      - 'null'
      - boolean
    doc: Drop indexes during load
    inputBinding:
      position: 102
      prefix: --keep-indexes
  - id: no_human_genome
    type:
      - 'null'
      - boolean
    doc: Use human chromosome enum type
    inputBinding:
      position: 102
      prefix: --no-human-genome
  - id: no_normalize
    type:
      - 'null'
      - boolean
    doc: Normalize variants
    inputBinding:
      position: 102
      prefix: --no-normalize
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Show progress bar
    inputBinding:
      position: 102
      prefix: --no-progress
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Normalize variants
    inputBinding:
      position: 102
      prefix: --normalize
  - id: port
    type:
      - 'null'
      - int
    doc: PostgreSQL port
    inputBinding:
      position: 102
      prefix: --port
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Show progress bar
    inputBinding:
      position: 102
      prefix: --progress
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress non-error output
    inputBinding:
      position: 102
      prefix: --quiet
  - id: sample_id
    type:
      - 'null'
      - string
    doc: Sample ID override
    inputBinding:
      position: 102
      prefix: --sample-id
  - id: schema
    type:
      - 'null'
      - string
    doc: Target schema
    inputBinding:
      position: 102
      prefix: --schema
  - id: user
    type:
      - 'null'
      - string
    doc: Database user
    inputBinding:
      position: 102
      prefix: --user
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose logging
    inputBinding:
      position: 102
      prefix: --verbose
  - id: workers
    type:
      - 'null'
      - int
    doc: Parallel workers
    inputBinding:
      position: 102
      prefix: --workers
outputs:
  - id: report
    type:
      - 'null'
      - File
    doc: Write JSON report to file
    outputBinding:
      glob: $(inputs.report)
  - id: log
    type:
      - 'null'
      - File
    doc: Write log to file
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf-pg-loader:0.5.4--pyhdfd78af_0
