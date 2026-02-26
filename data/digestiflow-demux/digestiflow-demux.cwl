cwlVersion: v1.2
class: CommandLineTool
baseCommand: digestiflow-demux
label: digestiflow-demux
doc: "Run demultiplexing for Digestiflow\n\nTool homepage: https://github.com/bihealth/digestiflow-demux"
inputs:
  - id: out_dir
    type: Directory
    doc: Path to output directory
    inputBinding:
      position: 1
  - id: seq_dir
    type:
      type: array
      items: Directory
    doc: Path(s) to sequencer raw data directories
    inputBinding:
      position: 2
  - id: api_read_only
    type:
      - 'null'
      - boolean
    doc: Do not write/update flowcell info to database
    inputBinding:
      position: 103
      prefix: --api-read-only
  - id: api_token
    type:
      - 'null'
      - string
    doc: API token to use for Digestiflow Web API
    inputBinding:
      position: 103
      prefix: --api-token
  - id: api_url
    type:
      - 'null'
      - string
    doc: URL to Digestiflow Web API
    inputBinding:
      position: 103
      prefix: --api-url
  - id: cluster_config
    type:
      - 'null'
      - File
    doc: Pass as --cluster-config to snakemake call.
    inputBinding:
      position: 103
      prefix: --cluster-config
  - id: config
    type:
      - 'null'
      - File
    doc: Path to configuration TOML file to load.
    inputBinding:
      position: 103
      prefix: --config
  - id: cores
    type:
      - 'null'
      - int
    doc: Degree of parallelism to use
    inputBinding:
      position: 103
      prefix: --cores
  - id: demux_tool
    type:
      - 'null'
      - string
    doc: Demultiplexing tool to use. Choices are Illumina's bcl2fastq(2) and 
      Picard
    inputBinding:
      position: 103
      prefix: --demux-tool
  - id: drmaa
    type:
      - 'null'
      - string
    doc: Pass as --drmaa argument to snakemake call (make sure to define 
      environment variable DRMAA_LIBRARY_PATH).
    inputBinding:
      position: 103
      prefix: --drmaa
  - id: filter_folder_names
    type:
      - 'null'
      - boolean
    doc: Filter folder names to those containing the vendor ID of a flow cell 
      that has been marked as ready for demultiplexing in the server.
    inputBinding:
      position: 103
      prefix: --filter-folder-names
  - id: force_demultiplexing
    type:
      - 'null'
      - boolean
    doc: Force demultiplexing even if flow cell not marked as ready
    inputBinding:
      position: 103
      prefix: --force-demultiplexing
  - id: jobscript
    type:
      - 'null'
      - File
    doc: Optional path to the jobscript to use when using DRMAA.
    inputBinding:
      position: 103
      prefix: --jobscript
  - id: keep_work_dir
    type:
      - 'null'
      - boolean
    doc: Keep temporary working directory (useful only for debugging)
    inputBinding:
      position: 103
      prefix: --keep-work-dir
  - id: lanes
    type:
      - 'null'
      - type: array
        items: string
    doc: Select individual lanes for demultiplexing; default is to use all for 
      which the sample sheet provides information; provide multiple times for 
      selecting multiple lanes.
    inputBinding:
      position: 103
      prefix: --lane
  - id: log_api_token
    type:
      - 'null'
      - boolean
    doc: Create log entry with API token (debug level; use only when debugging 
      as this has security implications)
    inputBinding:
      position: 103
      prefix: --log-api-token
  - id: max_jobs_per_second
    type:
      - 'null'
      - float
    doc: Max jobs per second to submit, default is 10.
    default: 10.0
    inputBinding:
      position: 103
      prefix: --max-jobs-per-second
  - id: only_post_message
    type:
      - 'null'
      - boolean
    doc: Only create the success message.
    inputBinding:
      position: 103
      prefix: --only-post-message
  - id: project_uuid
    type:
      - 'null'
      - string
    doc: Project UUID to register flowcell for
    inputBinding:
      position: 103
      prefix: --project-uuid
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease verbosity
    inputBinding:
      position: 103
      prefix: --quiet
  - id: tiles
    type:
      - 'null'
      - type: array
        items: string
    doc: Select tile regex; provide multiple times for multiple regexes with 
      bcl2fastq. Picard will use the first tile. Conflicts with --lane
    inputBinding:
      position: 103
      prefix: --tiles
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity
    inputBinding:
      position: 103
      prefix: --verbose
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: Specify working directory (instead of using temporary one)
    inputBinding:
      position: 103
      prefix: --work-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/digestiflow-demux:0.5.3--pyhdfd78af_0
stdout: digestiflow-demux.out
