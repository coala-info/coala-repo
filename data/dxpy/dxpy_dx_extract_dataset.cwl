cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dx
  - extract_dataset
label: dxpy_dx_extract_dataset
doc: 'Retrieves the data or generates SQL to retrieve the data from a dataset or cohort
  for a set of entity.fields. Additionally, the dataset''s dictionary can be extracted
  independently or in conjunction with data. Provides listing options for entities
  and fields.


  Tool homepage: https://github.com/dnanexus/dx-toolkit'
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: EnvVarRequirement
    envDef:
      DX_SECURITY_CONTEXT: '{"auth_token_type": "Bearer", "auth_token": "$(inputs.auth_token)"}'
      DX_PROJECT_CONTEXT_ID: "$(inputs.project_context_id ? inputs.project_context_id\
        \ : '')"
  - class: InlineJavascriptRequirement
inputs:
  - id: object_path
    type: string
    doc: v3.0 Dataset or Cohort object ID (project-id:record-id where "record-id"
      indicates the record ID in the currently selected project) or name
    inputBinding:
      position: 1
  - id: dump_dataset_dictionary
    type:
      - 'null'
      - boolean
    doc: If provided, the three dictionary files, <record_name>.data_dictionary.csv,
      <record_name>.entity_dictionary.csv, and <record_name>.codings.csv will be generated.
      Files will be comma delimited and written to the local working directory, unless
      otherwise specified using --delimiter and --output arguments. If stdout is specified
      with the output argument, the data dictionary, entity dictionary, and coding
      are output in succession, without separators. If any of the three dictionary
      files does not contain data (i.e. the dictionary is empty), then that particular
      file will not be created (or be output if the output is stdout).
    inputBinding:
      position: 101
      prefix: --dump-dataset-dictionary
  - id: fields
    type:
      - 'null'
      - string
    doc: 'A comma-separated string where each value is the phenotypic entity name
      and field name, separated by a dot. For example: "<entity_name>.<field_name>,<entity_
      name>.<field_name>". Internal spaces are permitted. If multiple entities are
      provided, field values will be automatically inner joined. If only the --fields
      argument is provided, data will be retrieved and returned. If both --fields
      and --sql arguments are provided, a SQL statement to retrieve the specified
      field data will be automatically generated and returned. Alternatively, use
      --fields-file option when the number of fields to be retrieved is large.'
    inputBinding:
      position: 101
      prefix: --fields
  - id: fields_file
    type:
      - 'null'
      - File
    doc: 'A file with no header and one entry per line where every entry is the phenotypic
      entity name and field name, separated by a dot. For example: <entity_name>.<field_name>.
      If multiple entities are provided, field values will be automatically inner
      joined. If only the --fields-file argument is provided, data will be retrieved
      and returned. If both --fields-file and --sql arguments are provided, a SQL
      statement to retrieve the specified field data will be automatically generated
      and returned. May not be used in conjunction with the argument --fields.'
    inputBinding:
      position: 101
      prefix: --fields-file
  - id: sql
    type:
      - 'null'
      - boolean
    doc: If provided, a SQL statement (string) will be returned to query the set of
      entity.fields, instead of returning stored values from the set of entity.fields
    inputBinding:
      position: 101
      prefix: --sql
  - id: delim
    type:
      - 'null'
      - string
    doc: Always use exactly one of DELIMITER to separate fields to be printed; if
      no delimiter is provided with this flag, COMMA will be used
    inputBinding:
      position: 101
      prefix: --delim
  - id: output
    type:
      - 'null'
      - string
    doc: Local filename or directory to be used ("-" indicates stdout output). If
      not supplied, output will create a file with a default name in the current folder
    inputBinding:
      position: 101
      prefix: --output
  - id: list_fields
    type:
      - 'null'
      - boolean
    doc: "List the names and titles of all fields available in the dataset specified.\
      \ When not specified together with \"\u2013-entities\", it will return all the\
      \ fields from the main entity. Output will be a two column table, field names\
      \ and field titles, separated by a tab, where field names will be of the format,\
      \ \"<entity name>.<field name>\" and field titles will be of the format, \"\
      <field title>\"."
    inputBinding:
      position: 101
      prefix: --list-fields
  - id: list_entities
    type:
      - 'null'
      - boolean
    doc: List the names and titles of all the entities available in the dataset specified.
      Output will be a two column table, entity names and entity titles, separated
      by a tab.
    inputBinding:
      position: 101
      prefix: --list-entities
  - id: entities
    type:
      - 'null'
      - string
    doc: 'Similar output to "--list-fields", however using "-- entities" will allow
      for specific entities to be specified. When multiple entities are specified,
      use comma as the delimiter. For example: "--list-fields --entities entityA,entityB,entityC"'
    inputBinding:
      position: 101
      prefix: --entities
  - id: auth_token
    type: string
    doc: DNAnexus authentication token; passed in the DX_SECURITY_CONTEXT 
      environment variable (this command has no --auth-token option)
  - id: project_context_id
    type:
      - 'null'
      - string
    doc: Default project or project context ID; passed in the 
      DX_PROJECT_CONTEXT_ID environment variable
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: extracted
    type:
      type: array
      items: File
    doc: Extracted data, SQL, dictionary or listing files
    outputBinding:
      glob: '$(inputs.output ? inputs.output : ''*.csv'')'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
stdout: dxpy_dx_extract_dataset.out
