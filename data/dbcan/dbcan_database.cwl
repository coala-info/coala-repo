cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - run_dbcan
  - database
label: dbcan_database
doc: "download dbCAN databases.\n\nTool homepage: http://bcb.unl.edu/dbCAN2/"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable verbose logging (equivalent to --log-level DEBUG)"
    inputBinding:
      position: 102
      prefix: --verbose
  - id: log_file
    type:
      - 'null'
      - string
    doc: "Write logs to file in addition to console"
    inputBinding:
      position: 102
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Set logging level (default: WARNING, only shows warnings and errors) (one of DEBUG, INFO, WARNING, ERROR, CRITICAL)"
    inputBinding:
      position: 102
      prefix: --log-level
  - id: aws_s3
    type:
      - 'null'
      - boolean
    doc: "Download databases from AWS S3"
    inputBinding:
      position: 102
      prefix: --aws_s3
  - id: cgc
    type:
      - 'null'
      - boolean
    doc: "Enable CGC-related databases (database download only)"
    inputBinding:
      position: 102
      prefix: --cgc
  - id: no_cgc
    type:
      - 'null'
      - boolean
    doc: "Turn off: Enable CGC-related databases (database download only)"
    inputBinding:
      position: 102
      prefix: --no-cgc
  - id: db_dir
    type: string
    doc: "Directory for the database [required]"
    inputBinding:
      position: 102
      prefix: --db_dir
outputs:
  - id: database
    type: Directory
    doc: Downloaded dbCAN database folder
    outputBinding:
      glob: $(inputs.db_dir)
  - id: log_output
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbcan:5.2.8--pyhdfd78af_0
