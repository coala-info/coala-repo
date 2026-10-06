cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- annonars
- db-utils
- copy
label: annonars_db-utils_copy
doc: '"copy" sub command: Copy all data, or the data in a position, range or BED regions, from one RocksDB
  database to a new one.


  Tool homepage: https://github.com/bihealth/annona-rs'
inputs:
- id: path_in
  type: Directory
  doc: Path to input directory
  inputBinding:
    position: 1
    prefix: --path-in
- id: path_out
  type: string
  doc: Path to output directory
  inputBinding:
    position: 1
    prefix: --path-out
- id: position
  type:
  - 'null'
  - string
  doc: Specify position to query for (e.g. GRCh37:17:41267752)
  inputBinding:
    position: 1
    prefix: --position
- id: range
  type:
  - 'null'
  - string
  doc: Specify range to query for (e.g. GRCh37:17:40000000:50000000)
  inputBinding:
    position: 1
    prefix: --range
- id: path_beds
  type:
  - 'null'
  - type: array
    items: File
    inputBinding:
      prefix: --path-beds
  doc: Specify path(s) to BED files to read from
  inputBinding:
    position: 1
- id: all
  type:
  - 'null'
  - boolean
  doc: Query for all variants
  inputBinding:
    position: 1
    prefix: --all
- id: skip_cfs
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --skip-cfs
  doc: Names of column families to skip contents for
  inputBinding:
    position: 1
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
  doc: Output RocksDB directory with the copied data
  outputBinding:
    glob: $(inputs.path_out)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
