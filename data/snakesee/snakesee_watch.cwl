cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakesee watch
label: snakesee_watch
doc: "Watch a Snakemake workflow in real-time with a TUI dashboard.\n\nTool homepage:
  https://github.com/nh13/snakesee"
inputs:
  - id: workflow_dir
    type:
      - 'null'
      - Directory
    doc: Path to workflow directory containing .snakemake/.
    default: .
    inputBinding:
      position: 1
  - id: half_life_days
    type:
      - 'null'
      - float
    doc: "Half-life in days for time-based weighting. After this many days, a run's
      weight is halved. Default: 7.0. Only used when weighting_strategy=\"time\"."
    default: 7.0
    inputBinding:
      position: 102
      prefix: --half-life-days
  - id: half_life_logs
    type:
      - 'null'
      - int
    doc: "Half-life in number of runs for index-based weighting. After this many runs,
      a run's weight is halved. Default: 10. Only used when weighting_strategy=\"\
      index\"."
    default: 10
    inputBinding:
      position: 102
      prefix: --half-life-logs
  - id: no_estimate
    type:
      - 'null'
      - boolean
    doc: Disable time estimation from historical data.
    default: false
    inputBinding:
      position: 102
      prefix: --no-estimate
  - id: no_wildcard_timing
    type:
      - 'null'
      - boolean
    doc: Use wildcard conditioning for estimates (estimate per sample/batch). 
      Enabled by default. Toggle with 'w' key in TUI.
    default: false
    inputBinding:
      position: 102
      prefix: --no-wildcard-timing
  - id: profile
    type:
      - 'null'
      - string
    doc: Optional path to a timing profile (.snakesee-profile.json) for 
      bootstrapping estimates. If not specified, will auto-discover.
    default: None
    inputBinding:
      position: 102
      prefix: --profile
  - id: refresh
    type:
      - 'null'
      - float
    doc: Refresh interval in seconds (0.5 to 60.0).
    default: 2.0
    inputBinding:
      position: 102
      prefix: --refresh
  - id: weighting_strategy
    type:
      - 'null'
      - string
    doc: Strategy for weighting historical timing data. "index" (default) - 
      weight by run index, ideal for active development where each run may fix 
      issues. "time" - weight by wall-clock time, better for stable pipelines.
    default: index
    inputBinding:
      position: 102
      prefix: --weighting-strategy
  - id: wildcard_timing
    type:
      - 'null'
      - boolean
    doc: Use wildcard conditioning for estimates (estimate per sample/batch). 
      Enabled by default. Toggle with 'w' key in TUI.
    default: true
    inputBinding:
      position: 102
      prefix: --wildcard-timing
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakesee:0.6.1--pyhdfd78af_0
stdout: snakesee_watch.out
