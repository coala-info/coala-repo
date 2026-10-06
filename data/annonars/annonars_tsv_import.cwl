cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- annonars
- tsv
- import
label: annonars_tsv_import
doc: '"import" sub command: Import generic variant TSV data into a RocksDB database.


  Tool homepage: https://github.com/bihealth/annona-rs'
inputs:
- id: genome_release
  type: string
  doc: 'Genome build to use in the build [possible values: grch37, grch38]'
  inputBinding:
    position: 1
    prefix: --genome-release
- id: path_in_tsv
  type:
    type: array
    items: File
    inputBinding:
      prefix: --path-in-tsv
  secondaryFiles:
  - pattern: .tbi
    required: false
  doc: Path to input TSV file(s)
  inputBinding:
    position: 1
- id: path_out_rocksdb
  type: string
  doc: Path to output RocksDB directory
  inputBinding:
    position: 1
    prefix: --path-out-rocksdb
- id: path_schema_json
  type:
  - 'null'
  - File
  doc: Optional path to schema dump in JSON format to start schema inference with
  inputBinding:
    position: 1
    prefix: --path-schema-json
- id: db_name
  type: string
  doc: Name of database to write to metadata
  inputBinding:
    position: 1
    prefix: --db-name
- id: db_version
  type: string
  doc: Version of database to write to metadata
  inputBinding:
    position: 1
    prefix: --db-version
- id: inference_row_count
  type:
  - 'null'
  - int
  doc: 'Number of rows for schema inference [default: 1000]'
  inputBinding:
    position: 1
    prefix: --inference-row-count
- id: skip_row_count
  type:
  - 'null'
  - int
  doc: 'Number of rows to skip [default: 0]'
  inputBinding:
    position: 1
    prefix: --skip-row-count
- id: tbi_window_size
  type:
  - 'null'
  - int
  doc: 'Windows size for TBI-based parallel import [default: 100000]'
  inputBinding:
    position: 1
    prefix: --tbi-window-size
- id: cf_name
  type:
  - 'null'
  - string
  doc: 'Name of the column family to import into [default: tsv_data]'
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
- id: col_chrom
  type: string
  doc: Name of column containing the chromosome
  inputBinding:
    position: 1
    prefix: --col-chrom
- id: col_start
  type: string
  doc: Name of column containing the 1-based start position
  inputBinding:
    position: 1
    prefix: --col-start
- id: col_ref
  type: string
  doc: Name of column containing the reference allele
  inputBinding:
    position: 1
    prefix: --col-ref
- id: col_alt
  type: string
  doc: Name of column containing the alternate allele
  inputBinding:
    position: 1
    prefix: --col-alt
- id: null_values
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --null-values
  doc: Values to be interpreted as null
  inputBinding:
    position: 1
- id: add_default_null_values
  type:
  - 'null'
  - boolean
  doc: Whether to add the default set of NULL values (NA, ., -)
  inputBinding:
    position: 1
    prefix: --add-default-null-values
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
