cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tb-profiler
  - update_tbdb
label: tb-profiler_update_tbdb
doc: "Download the tbdb mutation database from GitHub and build it\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
inputs:
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Database name'
    inputBinding:
      position: 101
      prefix: --prefix
  - id: repo
    type:
      - 'null'
      - string
    doc: 'Repository to pull from (default: https://github.com/jodyphelan/tbdb.git)'
    inputBinding:
      position: 101
      prefix: --repo
  - id: branch
    type:
      - 'null'
      - string
    doc: 'Branch to pull from (default: tbdb)'
    inputBinding:
      position: 101
      prefix: --branch
  - id: commit
    type:
      - 'null'
      - string
    doc: 'Git commit hash to checkout (default: latest)'
    inputBinding:
      position: 101
      prefix: --commit
  - id: match_ref
    type:
      - 'null'
      - string
    doc: 'Match the chromosome name to the given fasta file'
    inputBinding:
      position: 101
      prefix: --match_ref
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Force overwrite existing database with the same name'
    inputBinding:
      position: 101
      prefix: --force
  - id: db_dir
    type: string
    doc: 'Database directory to write to (default: /usr/local/share/tbprofiler in the image, which is read-only)'
    inputBinding:
      position: 101
      prefix: --db_dir
  - id: temp
    type:
      - 'null'
      - string
    doc: 'Temp directory to process all files (default: .)'
    inputBinding:
      position: 101
      prefix: --temp
  - id: logging
    type:
      - 'null'
      - string
    doc: 'Logging level: DEBUG, INFO, WARNING, ERROR or CRITICAL (default: INFO)'
    inputBinding:
      position: 101
      prefix: --logging
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: updated_db_dir
    type:
      - 'null'
      - Directory
    doc: 'Database directory with the new database'
    outputBinding:
      glob: $(inputs.db_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
stdout: tb-profiler_update_tbdb.out
