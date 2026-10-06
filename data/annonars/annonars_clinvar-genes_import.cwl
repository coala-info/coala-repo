cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- annonars
- clinvar-genes
- import
label: annonars_clinvar-genes_import
doc: '"import" sub command: Import ClinVar per-gene data (per-impact and per-frequency counts and variants)
  into a RocksDB database.


  Tool homepage: https://github.com/bihealth/annona-rs'
inputs:
- id: path_per_impact_jsonl
  type: File
  doc: Path to input per-impact JSONL file(s)
  inputBinding:
    position: 1
    prefix: --path-per-impact-jsonl
- id: path_per_frequency_jsonl
  type: File
  doc: Path to input per-frequency JSONL file(s)
  inputBinding:
    position: 1
    prefix: --path-per-frequency-jsonl
- id: paths_variant_jsonl
  type:
    type: array
    items: File
    inputBinding:
      prefix: --paths-variant-jsonl
  doc: Paths to variant JSONL files
  inputBinding:
    position: 1
- id: path_out_rocksdb
  type: string
  doc: Path to output RocksDB directory
  inputBinding:
    position: 1
    prefix: --path-out-rocksdb
- id: cf_name
  type:
  - 'null'
  - string
  doc: 'Name of the column family to import into [default: clinvar-genes]'
  inputBinding:
    position: 1
    prefix: --cf-name
- id: path_wal_dir
  type:
  - 'null'
  - string
  doc: Optional path to RocksDB WAL directory
  inputBinding:
    position: 1
    prefix: --path-wal-dir
- id: verbose
  type:
  - 'null'
  - boolean
  doc: Increase logging verbosity
  inputBinding:
    position: 1
    prefix: --verbose
- id: quiet
  type:
  - 'null'
  - boolean
  doc: Decrease logging verbosity
  inputBinding:
    position: 1
    prefix: --quiet
outputs:
- id: rocksdb
  type: Directory
  doc: Output RocksDB directory
  outputBinding:
    glob: $(inputs.path_out_rocksdb)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
