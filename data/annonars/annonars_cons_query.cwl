cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- annonars
- cons
- query
label: annonars_cons_query
doc: '"query" sub command: Query UCSC multiz conservation data in a RocksDB database built by import.


  Tool homepage: https://github.com/bihealth/annona-rs'
inputs:
- id: path_rocksdb
  type: Directory
  doc: Path to RocksDB directory with data
  inputBinding:
    position: 1
    prefix: --path-rocksdb
- id: cf_name
  type:
  - 'null'
  - string
  doc: 'Name of the column family to import into [default: ucsc_conservation]'
  inputBinding:
    position: 1
    prefix: --cf-name
- id: out_file
  type:
  - 'null'
  - string
  default: annonars_cons_query.jsonl
  doc: Output file (default is stdout == "-")
  inputBinding:
    position: 1
    prefix: --out-file
- id: out_format
  type:
  - 'null'
  - string
  doc: 'Output format [default: jsonl] [possible values: jsonl]'
  inputBinding:
    position: 1
    prefix: --out-format
- id: range
  type:
  - 'null'
  - string
  doc: Specify range to query for (e.g. GRCh37:17:40000000:50000000)
  inputBinding:
    position: 1
    prefix: --range
- id: all
  type:
  - 'null'
  - boolean
  doc: Query for all variants
  inputBinding:
    position: 1
    prefix: --all
- id: hgnc_id
  type:
  - 'null'
  - string
  doc: Optional HGNC gene identifier to limit query to
  inputBinding:
    position: 1
    prefix: --hgnc-id
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
- id: query_result
  type: File
  doc: Query result in JSONL format
  outputBinding:
    glob: $(inputs.out_file)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
