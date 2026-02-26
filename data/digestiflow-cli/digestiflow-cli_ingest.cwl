cwlVersion: v1.2
class: CommandLineTool
baseCommand: digestiflow-cli ingest
label: digestiflow-cli_ingest
doc: "Analyze an Illumina flow cell directory\n\nTool homepage: https://github.com/bihealth/digestiflow-cli"
inputs:
  - id: flowcell_dir
    type:
      type: array
      items: Directory
    doc: Path flow cell directory.
    inputBinding:
      position: 1
  - id: analyze_adapters
    type:
      - 'null'
      - boolean
    doc: Read adapters from binary base call files
    inputBinding:
      position: 102
      prefix: --analyze-adapters
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Do not perform any modifying operations
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: force_analyze_adapters
    type:
      - 'null'
      - boolean
    doc: "Force analysis of adapters even if adapter histogram information is present
      for all\n                                    index reads."
    inputBinding:
      position: 102
      prefix: --force-analyze-adapters
  - id: log_token
    type:
      - 'null'
      - boolean
    doc: "Print authentation token to log file (useful for debugging, possible leaking\n\
      \                                    security issue)"
    inputBinding:
      position: 102
      prefix: --log-token
  - id: min_index_fraction
    type:
      - 'null'
      - float
    doc: "Minimal fraction of reads that must show index for index histogram to be\n\
      \                                           computed"
    inputBinding:
      position: 102
      prefix: --min-index-fraction
  - id: no_register
    type:
      - 'null'
      - boolean
    doc: Whether or not to register flow cell via the API.
    inputBinding:
      position: 102
      prefix: --no-register
  - id: no_update
    type:
      - 'null'
      - boolean
    doc: Whether or not to update the flow cell via the API
    inputBinding:
      position: 102
      prefix: --no-update
  - id: project_uuid
    type:
      - 'null'
      - string
    doc: The UUID of the project to write to.
    inputBinding:
      position: 102
      prefix: --project-uuid
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease verbosity
    inputBinding:
      position: 102
      prefix: --quiet
  - id: sample_reads_per_tile
    type:
      - 'null'
      - int
    doc: Number of reads to sample per tile
    inputBinding:
      position: 102
      prefix: --sample-reads-per-tile
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use for (de)compression in I/O.
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: update_if_state_final
    type:
      - 'null'
      - boolean
    doc: "Update flow cell information sequencing is in a final state (e.g., completed
      or\n                                    failed).  Updating index histograms
      is separate from this."
    inputBinding:
      position: 102
      prefix: --update-if-state-final
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/digestiflow-cli:0.5.8--hc234bb7_7
stdout: digestiflow-cli_ingest.out
