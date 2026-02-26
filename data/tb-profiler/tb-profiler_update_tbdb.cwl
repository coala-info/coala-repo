cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tb-profiler
  - update_tbdb
label: tb-profiler_update_tbdb
doc: "Update the TB-Profiler database\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
inputs:
  - id: branch
    type:
      - 'null'
      - string
    doc: Branch to pull from
    default: tbdb
    inputBinding:
      position: 101
      prefix: --branch
  - id: commit
    type:
      - 'null'
      - string
    doc: Git commit hash to checkout
    default: latest
    inputBinding:
      position: 101
      prefix: --commit
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: Database directory
    default: /usr/local/share/tbprofiler
    inputBinding:
      position: 101
      prefix: --db_dir
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite existing database with the same name
    default: false
    inputBinding:
      position: 101
      prefix: --force
  - id: logging
    type:
      - 'null'
      - string
    doc: Logging level
    default: INFO
    inputBinding:
      position: 101
      prefix: --logging
  - id: match_ref
    type:
      - 'null'
      - string
    doc: The prefix for all output files
    default: None
    inputBinding:
      position: 101
      prefix: --match-ref
  - id: prefix
    type:
      - 'null'
      - string
    doc: Database name
    default: None
    inputBinding:
      position: 101
      prefix: --prefix
  - id: repo
    type:
      - 'null'
      - string
    doc: Repository to pull from
    default: https://github.com/jodyphelan/tbdb.git
    inputBinding:
      position: 101
      prefix: --repo
  - id: temp
    type:
      - 'null'
      - Directory
    doc: Temp firectory to process all files
    default: .
    inputBinding:
      position: 101
      prefix: --temp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
stdout: tb-profiler_update_tbdb.out
