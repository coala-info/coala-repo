cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tb-profiler
  - batch
label: tb-profiler_batch
doc: "Run tb-profiler profile on many samples listed in a CSV file\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
inputs:
  - id: csv
    type: File
    doc: 'CSV with samples and files (the file names must be those of the staged input files)'
    inputBinding:
      position: 101
      prefix: --csv
  - id: args
    type:
      - 'null'
      - string
    doc: 'Arguments to use with tb-profiler profile'
    inputBinding:
      position: 101
      prefix: --args
  - id: jobs
    type:
      - 'null'
      - int
    doc: 'Number of samples to run at the same time (default: 1)'
    inputBinding:
      position: 101
      prefix: --jobs
  - id: threads_per_job
    type:
      - 'null'
      - int
    doc: 'Threads to use per job (default: 1)'
    inputBinding:
      position: 101
      prefix: --threads_per_job
  - id: dir
    type:
      - 'null'
      - string
    doc: 'Storage directory (default: .)'
    inputBinding:
      position: 101
      prefix: --dir
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: 'Database directory (default: bundled database in the image)'
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
  - id: input_files
    type:
      type: array
      items: File
    doc: 'Read and BAM files named in the CSV file; they are staged in the working directory'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: results_dir
    type:
      - 'null'
      - Directory
    doc: 'Results directory'
    outputBinding:
      glob: $((inputs.dir || '.') + '/results')
  - id: bam_dir
    type:
      - 'null'
      - Directory
    doc: 'Mapped reads directory'
    outputBinding:
      glob: $((inputs.dir || '.') + '/bam')
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.input_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
stdout: tb-profiler_batch.out
