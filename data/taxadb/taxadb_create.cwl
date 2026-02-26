cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxadb_create
label: taxadb_create
doc: "build the database\n\nTool homepage: https://github.com/HadrienG/taxadb"
inputs:
  - id: chunk
    type:
      - 'null'
      - int
    doc: Number of sequences to insert in bulk
    default: 500
    inputBinding:
      position: 101
      prefix: --chunk
  - id: database_name
    type:
      - 'null'
      - string
    doc: name of the database
    default: taxadb
    inputBinding:
      position: 101
      prefix: --dbname
  - id: db_type
    type:
      - 'null'
      - string
    doc: type of the database
    default: sqlite
    inputBinding:
      position: 101
      prefix: --dbtype
  - id: division
    type:
      - 'null'
      - string
    doc: division to build
    default: full
    inputBinding:
      position: 101
      prefix: --division
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Disables checks for faster db creation. Use with caution!
    inputBinding:
      position: 101
      prefix: --fast
  - id: hostname
    type:
      - 'null'
      - string
    doc: Database connection host (Optional, for MySQLdatabase and 
      PostgreSQLdatabase)
    default: localhost
    inputBinding:
      position: 101
      prefix: --hostname
  - id: input_dir
    type: Directory
    doc: Input directory (where you first downloaded the files)
    inputBinding:
      position: 101
      prefix: --input
  - id: password
    type:
      - 'null'
      - string
    doc: Password to use (required for MySQLdatabase and PostgreSQLdatabase)
    inputBinding:
      position: 101
      prefix: --password
  - id: port
    type:
      - 'null'
      - int
    doc: 'Database connection port (default: 5432 (postgres), 3306 (MySQL))'
    inputBinding:
      position: 101
      prefix: --port
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Disable info logging.
    default: false
    inputBinding:
      position: 101
      prefix: --quiet
  - id: username
    type:
      - 'null'
      - string
    doc: Username to login as (required for MySQLdatabase and 
      PostgreSQLdatabase)
    inputBinding:
      position: 101
      prefix: --username
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable debug logging.
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxadb:0.12.1--pyh5e36f6f_0
stdout: taxadb_create.out
