cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tb-profiler
  - reformat
label: tb-profiler_reformat
doc: "Sample prefix\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
inputs:
  - id: json
    type: string
    doc: Sample prefix
    inputBinding:
      position: 1
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Add CSV output
    default: false
    inputBinding:
      position: 102
      prefix: --csv
  - id: db
    type:
      - 'null'
      - string
    doc: Mutation panel name
    default: tbdb
    inputBinding:
      position: 102
      prefix: --db
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: Database directory
    default: /usr/local/share/tbprofiler
    inputBinding:
      position: 102
      prefix: --db_dir
  - id: dir
    type:
      - 'null'
      - Directory
    doc: Storage directory
    default: .
    inputBinding:
      position: 102
      prefix: --dir
  - id: docx
    type:
      - 'null'
      - boolean
    doc: Add docx output. This requires docxtpl to be installed
    default: false
    inputBinding:
      position: 102
      prefix: --docx
  - id: docx_plugin
    type:
      - 'null'
      - string
    doc: Use a plugin template for --docx output
    inputBinding:
      position: 102
      prefix: --docx_plugin
  - id: docx_template
    type:
      - 'null'
      - string
    doc: Supply custom template for --docx output
    inputBinding:
      position: 102
      prefix: --docx_template
  - id: external_db
    type:
      - 'null'
      - string
    doc: Path to db files prefix (overrides "--db" parameter)
    inputBinding:
      position: 102
      prefix: --external_db
  - id: logging
    type:
      - 'null'
      - string
    doc: Logging level
    default: INFO
    inputBinding:
      position: 102
      prefix: --logging
  - id: temp
    type:
      - 'null'
      - Directory
    doc: Temp firectory to process all files
    default: .
    inputBinding:
      position: 102
      prefix: --temp
  - id: text_template
    type:
      - 'null'
      - string
    doc: Jinja2 formatted template for output
    inputBinding:
      position: 102
      prefix: --text_template
  - id: txt
    type:
      - 'null'
      - boolean
    doc: Add text output
    default: false
    inputBinding:
      position: 102
      prefix: --txt
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
stdout: tb-profiler_reformat.out
