cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varfish-server-worker
  - seqvars
  - aggregate
label: varfish-server-worker_seqvars_aggregate
doc: 'Build/update seqvars inhouse database.


  Tool homepage: https://github.com/varfish-org/varfish-server-worker'
inputs:
  - id: genomebuild
    type: string
    doc: The assumed genome build (grch37 or grch38)
    inputBinding:
      position: 102
      prefix: --genomebuild
  - id: path_out_rocksdb
    type: string
    doc: Path to the output RocksDB
    inputBinding:
      position: 102
      prefix: --path-out-rocksdb
  - id: path_input
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --path-input
    doc: Path to input VCF file(s)
    inputBinding:
      position: 102
  - id: cf_counts
    type:
      - 'null'
      - string
    doc: 'Column family name for the count data [default: counts]'
    inputBinding:
      position: 102
      prefix: --cf-counts
  - id: cf_carriers
    type:
      - 'null'
      - string
    doc: 'Column family name for the carrier UUID data [default: carriers]'
    inputBinding:
      position: 102
      prefix: --cf-carriers
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Set the number of threads to use, defaults to number of cores
    inputBinding:
      position: 102
      prefix: --num-threads
  - id: path_wal_dir
    type:
      - 'null'
      - string
    doc: Optional path to RocksDB WAL directory
    inputBinding:
      position: 102
      prefix: --path-wal-dir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase logging verbosity
    inputBinding:
      position: 102
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease logging verbosity
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: output_rocksdb
    type:
      - 'null'
      - Directory
    doc: Output RocksDB directory
    outputBinding:
      glob: $(inputs.path_out_rocksdb)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varfish-server-worker:0.17.3--h13c227e_0
