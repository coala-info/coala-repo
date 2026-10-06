cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- annonars
- clinvar-sv
- import
label: annonars_clinvar-sv_import
doc: '"import" sub command: Import ClinVar structural variant data into a RocksDB database.


  Tool homepage: https://github.com/bihealth/annona-rs'
inputs:
- id: genome_release
  type: string
  doc: 'Genome build to use in the build [possible values: grch37, grch38]'
  inputBinding:
    position: 1
    prefix: --genome-release
- id: path_in_jsonl
  type:
    type: array
    items: File
    inputBinding:
      prefix: --path-in-jsonl
  doc: Path to input JSONL file(s)
  inputBinding:
    position: 1
- id: path_out_rocksdb
  type: string
  doc: Path to output RocksDB directory
  inputBinding:
    position: 1
    prefix: --path-out-rocksdb
- id: min_var_size
  type:
  - 'null'
  - int
  doc: 'Minimal VCF REF/ALT length to consider as SV [default: 50]'
  inputBinding:
    position: 1
    prefix: --min-var-size
- id: cf_name
  type:
  - 'null'
  - string
  doc: 'Name of the column family to import into [default: clinvar_sv]'
  inputBinding:
    position: 1
    prefix: --cf-name
- id: cf_name_by_rcv
  type:
  - 'null'
  - string
  doc: 'Mapping from ClinVar RCV to ClinVar VCV [default: clinvar_sv_by_rcv]'
  inputBinding:
    position: 1
    prefix: --cf-name-by-rcv
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
