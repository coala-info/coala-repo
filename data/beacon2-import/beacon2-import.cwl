cwlVersion: v1.2
class: CommandLineTool
baseCommand: beacon2-import
label: beacon2-import
doc: "Input arguments\n\nTool homepage: https://pypi.org/project/beacon2-import/"
inputs:
  - id: advance_connection
    type:
      - 'null'
      - boolean
    doc: Connect to beacon database with authentication
    inputBinding:
      position: 101
      prefix: --advance-connection
  - id: clear_all
    type:
      - 'null'
      - boolean
    doc: Delete all data before the new import
    inputBinding:
      position: 101
      prefix: --clearAll
  - id: clear_coll
    type:
      - 'null'
      - boolean
    doc: Delete specific collection before the new import
    inputBinding:
      position: 101
      prefix: --clearColl
  - id: collection
    type:
      - 'null'
      - string
    doc: The targeted beacon collection from the desired database
    inputBinding:
      position: 101
      prefix: --collection
  - id: database
    type:
      - 'null'
      - string
    doc: The targeted beacon database
    inputBinding:
      position: 101
      prefix: --database
  - id: database_auth_config
    type:
      - 'null'
      - string
    doc: JSON file containing credentials/config e.g.{'db_auth_ 
      source':'admin','db_user':'root','db_password':'example'}
    inputBinding:
      position: 101
      prefix: --db-auth-config
  - id: database_host
    type:
      - 'null'
      - string
    doc: Hostname/IP of the beacon database
    inputBinding:
      position: 101
      prefix: --db-host
  - id: database_port
    type:
      - 'null'
      - int
    doc: Port of the beacon database
    inputBinding:
      position: 101
      prefix: --db-port
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: galaxy
    type:
      - 'null'
      - boolean
    doc: Import data from Galaxy
    inputBinding:
      position: 101
      prefix: --galaxy
  - id: galaxy_key
    type:
      - 'null'
      - string
    doc: API key of a galaxy user WITH ADMIN PRIVILEGES
    inputBinding:
      position: 101
      prefix: --galaxy-key
  - id: galaxy_url
    type:
      - 'null'
      - string
    doc: Galaxy hostname or IP
    inputBinding:
      position: 101
      prefix: --galaxy-url
  - id: input_json_file
    type:
      - 'null'
      - File
    doc: Input the local path to the JSON file or it's name on your Galaxy 
      Hitory to import to beacon
    inputBinding:
      position: 101
      prefix: --input_json_file
  - id: remove_collection
    type:
      - 'null'
      - string
    doc: Define the collection name for deletion
    inputBinding:
      position: 101
      prefix: --removeCollection
  - id: store_origins
    type:
      - 'null'
      - boolean
    doc: Make a local file containing variantIDs with the dataset they stem from
    inputBinding:
      position: 101
      prefix: --store-origins
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: origins_file
    type:
      - 'null'
      - File
    doc: Full file path of where variant origins should be stored (if enabled)
    outputBinding:
      glob: $(inputs.origins_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beacon2-import:2.2.4--pyhdfd78af_0
