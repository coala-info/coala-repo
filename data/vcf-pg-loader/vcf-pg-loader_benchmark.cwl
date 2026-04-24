cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf-pg-loader
  - benchmark
label: vcf-pg-loader_benchmark
doc: "Run performance benchmarks on VCF parsing and loading.\n\nTool homepage: https://github.com/Zacharyr41/vcf-pg-loader"
inputs:
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Records per batch
    inputBinding:
      position: 101
      prefix: --batch
  - id: db_url
    type:
      - 'null'
      - string
    doc: PostgreSQL URL (omit for parsing-only benchmark)
    inputBinding:
      position: 101
      prefix: --db
  - id: giab_style
    type:
      - 'null'
      - boolean
    doc: Generate GIAB-style VCF with platform/callset metadata
    inputBinding:
      position: 101
      prefix: --giab
  - id: no_human_genome
    type:
      - 'null'
      - boolean
    doc: Do not use human chromosome enum type
    inputBinding:
      position: 101
      prefix: --no-human-genome
  - id: no_normalize_variants
    type:
      - 'null'
      - boolean
    doc: Do not normalize variants
    inputBinding:
      position: 101
      prefix: --no-normalize
  - id: normalize_variants
    type:
      - 'null'
      - boolean
    doc: Normalize variants
    inputBinding:
      position: 101
      prefix: --normalize
  - id: output_json
    type:
      - 'null'
      - boolean
    doc: Output results as JSON
    inputBinding:
      position: 101
      prefix: --json
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Minimal output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: realistic_vcf
    type:
      - 'null'
      - boolean
    doc: Generate realistic VCF with annotations and complex variants
    inputBinding:
      position: 101
      prefix: --realistic
  - id: synthetic_variants
    type:
      - 'null'
      - int
    doc: Generate synthetic VCF with N variants
    inputBinding:
      position: 101
      prefix: --synthetic
  - id: use_human_genome
    type:
      - 'null'
      - boolean
    doc: Use human chromosome enum type
    inputBinding:
      position: 101
      prefix: --human-genome
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: Path to VCF file
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf-pg-loader:0.5.4--pyhdfd78af_0
stdout: vcf-pg-loader_benchmark.out
