cwlVersion: v1.2
class: CommandLineTool
baseCommand: tb-profiler batch
label: tb-profiler_batch
doc: "Run tb-profiler on multiple samples defined in a CSV file.\n\nTool homepage:
  https://github.com/jodyphelan/TBProfiler"
inputs:
  - id: args
    type:
      - 'null'
      - string
    doc: Arguments to use with tb-profiler
    default: None
    inputBinding:
      position: 101
      prefix: --args
  - id: csv
    type: File
    doc: CSV with samples and files
    default: None
    inputBinding:
      position: 101
      prefix: --csv
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: Database directory
    default: /usr/local/share/tbprofiler
    inputBinding:
      position: 101
      prefix: --db_dir
  - id: dir
    type:
      - 'null'
      - Directory
    doc: Storage directory
    default: .
    inputBinding:
      position: 101
      prefix: --dir
  - id: jobs
    type:
      - 'null'
      - int
    doc: Threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --jobs
  - id: logging
    type:
      - 'null'
      - string
    doc: Logging level
    default: INFO
    inputBinding:
      position: 101
      prefix: --logging
  - id: temp
    type:
      - 'null'
      - Directory
    doc: Temp firectory to process all files
    default: .
    inputBinding:
      position: 101
      prefix: --temp
  - id: threads_per_job
    type:
      - 'null'
      - int
    doc: Threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads_per_job
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
stdout: tb-profiler_batch.out
