cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- annonars
- freqs
- query
label: annonars_freqs_query
doc: '"query" sub command: Query merged gnomAD and HelixMtDb frequency data in a RocksDB database built
  by import.


  Tool homepage: https://github.com/bihealth/annona-rs'
inputs:
- id: path_rocksdb
  type: Directory
  doc: Path to RocksDB directory with data
  inputBinding:
    position: 1
    prefix: --path-rocksdb
- id: path_output
  type:
  - 'null'
  - string
  default: annonars_freqs_query.jsonl
  doc: Path to output file, use "-" for stdout
  inputBinding:
    position: 1
    prefix: --path-output
- id: out_format
  type:
  - 'null'
  - string
  doc: 'Output format [default: jsonl] [possible values: jsonl]'
  inputBinding:
    position: 1
    prefix: --out-format
- id: variant
  type: string
  doc: Variant to query for (e.g. GRCh37:17:41267746:C:CA)
  inputBinding:
    position: 1
    prefix: --variant
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
    glob: $(inputs.path_output)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
