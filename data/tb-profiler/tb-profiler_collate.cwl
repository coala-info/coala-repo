cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tb-profiler
  - collate
label: tb-profiler_collate
doc: "Collate results from several samples into summary tables\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
inputs:
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Output prefix (default: tbprofiler)'
    inputBinding:
      position: 101
      prefix: --prefix
  - id: samples
    type:
      - 'null'
      - File
    doc: 'File with samples (one per line)'
    inputBinding:
      position: 101
      prefix: --samples
  - id: itol
    type:
      - 'null'
      - boolean
    doc: 'Generate itol config files'
    inputBinding:
      position: 101
      prefix: --itol
  - id: full
    type:
      - 'null'
      - boolean
    doc: 'Output mutations in main result file'
    inputBinding:
      position: 101
      prefix: --full
  - id: all_variants
    type:
      - 'null'
      - boolean
    doc: 'Output all variants in variant matrix'
    inputBinding:
      position: 101
      prefix: --all_variants
  - id: mark_missing
    type:
      - 'null'
      - boolean
    doc: 'An asterisk will be used to mark predictions which are affected by missing data at a drug resistance position'
    inputBinding:
      position: 101
      prefix: --mark_missing
  - id: add_positions
    type:
      - 'null'
      - boolean
    doc: 'Add variant positions to the transmission graph output'
    inputBinding:
      position: 101
      prefix: --add_positions
  - id: db
    type:
      - 'null'
      - string
    doc: 'Mutation panel name (default: tbdb)'
    inputBinding:
      position: 101
      prefix: --db
  - id: format
    type:
      - 'null'
      - string
    doc: 'Format of the output: txt or csv (default: txt)'
    inputBinding:
      position: 101
      prefix: --format
  - id: external_db
    type:
      - 'null'
      - string
    doc: 'Path to db files prefix (overrides the db option)'
    inputBinding:
      position: 101
      prefix: --external_db
  - id: result_dirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: 'Directories with the per-sample result files written by tb-profiler profile (default: results)'
    inputBinding:
      position: 101
      prefix: --dir
  - id: temp
    type:
      - 'null'
      - string
    doc: 'Temp directory to process all files (default: .)'
    inputBinding:
      position: 101
      prefix: --temp
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: 'Database directory (default: bundled database in the image)'
    inputBinding:
      position: 101
      prefix: --db_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: collate_files
    type:
      type: array
      items: File
    doc: 'Collated result files'
    outputBinding:
      glob: $((inputs.prefix || 'tbprofiler') + '.*')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
stdout: tb-profiler_collate.out
