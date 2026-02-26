cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ntm-profiler
  - update_db
label: ntm-profiler_update_db
doc: "Update the ntm-profiler database.\n\nTool homepage: https://github.com/jodyphelan/NTM-Profiler"
inputs:
  - id: branch
    type:
      - 'null'
      - string
    doc: Storage directory
    default: main
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
    doc: Storage directory
    default: /usr/local/share/ntm-profiler/
    inputBinding:
      position: 101
      prefix: --db_dir
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug logging
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: dir
    type:
      - 'null'
      - Directory
    doc: Storage directory
    default: .
    inputBinding:
      position: 101
      prefix: --dir
  - id: logging
    type:
      - 'null'
      - string
    doc: Logging level
    default: INFO
    inputBinding:
      position: 101
      prefix: --logging
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Don't remove temporary files after run
    default: false
    inputBinding:
      position: 101
      prefix: --no_cleanup
  - id: repo
    type:
      - 'null'
      - string
    doc: Repository to pull from
    default: https://github.com/pathogen-profiler/ntm-db.git
    inputBinding:
      position: 101
      prefix: --repo
  - id: temp
    type:
      - 'null'
      - Directory
    doc: Temp directory to process all files
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
    dockerPull: quay.io/biocontainers/ntm-profiler:0.8.1--pyhdfd78af_0
stdout: ntm-profiler_update_db.out
