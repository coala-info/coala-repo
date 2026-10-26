cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varfish-server-worker
  - seqvars
  - query
label: varfish-server-worker_seqvars_query
doc: 'Run query for seqvars.


  Tool homepage: https://github.com/varfish-org/varfish-server-worker'
inputs:
  - id: genome_release
    type: string
    doc: Genome release to assume (grch37 or grch38)
    inputBinding:
      position: 102
      prefix: --genome-release
  - id: result_set_id
    type:
      - 'null'
      - string
    doc: Result set ID
    inputBinding:
      position: 102
      prefix: --result-set-id
  - id: case_uuid
    type:
      - 'null'
      - string
    doc: The case UUID
    inputBinding:
      position: 102
      prefix: --case-uuid
  - id: path_db
    type: Directory
    doc: Path to worker database to use for querying
    inputBinding:
      position: 102
      prefix: --path-db
  - id: path_inhouse_db
    type:
      - 'null'
      - Directory
    doc: Path to inhouse rocksdb folder
    inputBinding:
      position: 102
      prefix: --path-inhouse-db
  - id: path_query_json
    type: File
    doc: Path to query JSON file
    inputBinding:
      position: 102
      prefix: --path-query-json
  - id: path_input
    type: File
    doc: Path to input TSV file
    inputBinding:
      position: 102
      prefix: --path-input
  - id: path_output
    type: string
    doc: Path to the output TSV file
    inputBinding:
      position: 102
      prefix: --path-output
  - id: max_results
    type:
      - 'null'
      - int
    doc: Optional maximal number of total records to write out
    inputBinding:
      position: 102
      prefix: --max-results
  - id: rng_seed
    type:
      - 'null'
      - int
    doc: Optional seed for RNG
    inputBinding:
      position: 102
      prefix: --rng-seed
  - id: max_tad_distance
    type:
      - 'null'
      - int
    doc: 'Maximal distance to TAD to consider (unused, but required when loading database)
      [default: 10000]'
    inputBinding:
      position: 102
      prefix: --max-tad-distance
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
  - id: output_tsv
    type:
      - 'null'
      - File
    doc: Query result TSV file
    outputBinding:
      glob: $(inputs.path_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varfish-server-worker:0.17.3--h13c227e_0
