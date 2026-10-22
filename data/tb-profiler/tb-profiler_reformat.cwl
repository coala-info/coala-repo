cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tb-profiler
  - reformat
label: tb-profiler_reformat
doc: "Re-create text, csv or docx reports from a JSON result file\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
inputs:
  - id: json
    type: File
    doc: 'JSON result file written by tb-profiler profile'
    inputBinding:
      position: 1
  - id: txt
    type:
      - 'null'
      - boolean
    doc: 'Add text output'
    inputBinding:
      position: 101
      prefix: --txt
  - id: csv
    type:
      - 'null'
      - boolean
    doc: 'Add CSV output'
    inputBinding:
      position: 101
      prefix: --csv
  - id: docx
    type:
      - 'null'
      - boolean
    doc: 'Add docx output. This requires docxtpl to be installed'
    inputBinding:
      position: 101
      prefix: --docx
  - id: docx_template
    type:
      - 'null'
      - File
    doc: 'Supply custom template for docx output'
    inputBinding:
      position: 101
      prefix: --docx_template
  - id: docx_plugin
    type:
      - 'null'
      - string
    doc: 'Use a plugin template for docx output (default)'
    inputBinding:
      position: 101
      prefix: --docx_plugin
  - id: text_template
    type:
      - 'null'
      - File
    doc: 'Jinja2 formatted template for output'
    inputBinding:
      position: 101
      prefix: --text_template
  - id: db
    type:
      - 'null'
      - string
    doc: 'Mutation panel name (default: tbdb)'
    inputBinding:
      position: 101
      prefix: --db
  - id: external_db
    type:
      - 'null'
      - string
    doc: 'Path to db files prefix (overrides the db option)'
    inputBinding:
      position: 101
      prefix: --external_db
  - id: dir
    type:
      - 'null'
      - string
    doc: 'Storage directory for results (default: current directory)'
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
  - id: results_dir
    type:
      - 'null'
      - Directory
    doc: 'Results directory'
    outputBinding:
      glob: $((inputs.dir || '.') + '/results')
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: results
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
stdout: tb-profiler_reformat.out
