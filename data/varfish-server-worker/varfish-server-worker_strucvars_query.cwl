cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varfish-server-worker
  - strucvars
  - query
label: varfish-server-worker_strucvars_query
doc: 'Run query for strucvars.


  Tool homepage: https://github.com/varfish-org/varfish-server-worker'
inputs:
  - id: genome_release
    type: string
    doc: Genome release to assume (grch37 or grch38)
    inputBinding:
      position: 102
      prefix: --genome-release
  - id: path_db
    type: Directory
    doc: Path to worker database to use for querying
    inputBinding:
      position: 102
      prefix: --path-db
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
  - id: slack_bnd
    type:
      - 'null'
      - int
    doc: 'Radius around BND sites used when building the database [default: 50]'
    inputBinding:
      position: 102
      prefix: --slack-bnd
  - id: slack_ins
    type:
      - 'null'
      - int
    doc: 'Radius around INS sites used when building the database [default: 50]'
    inputBinding:
      position: 102
      prefix: --slack-ins
  - id: min_overlap
    type:
      - 'null'
      - float
    doc: 'Minimal reciprocal overlap for SVs of the same type, used when building
      the database [default: 0.8]'
    inputBinding:
      position: 102
      prefix: --min-overlap
  - id: max_tad_distance
    type:
      - 'null'
      - int
    doc: 'Maximal distance to TAD to consider [default: 10000]'
    inputBinding:
      position: 102
      prefix: --max-tad-distance
  - id: rng_seed
    type:
      - 'null'
      - int
    doc: Optional seed for RNG
    inputBinding:
      position: 102
      prefix: --rng-seed
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
