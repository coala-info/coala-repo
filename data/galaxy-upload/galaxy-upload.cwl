cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-upload
label: galaxy-upload
doc: "Upload files to a Galaxy instance\n\nTool homepage: https://github.com/galaxyproject/galaxy-upload"
inputs:
  - id: path
    type:
      - 'null'
      - type: array
        items: File
    doc: Path(s) to upload
    inputBinding:
      position: 1
  - id: api_key
    type: string
    doc: API key for Galaxy instance
    inputBinding:
      position: 102
      prefix: --api-key
  - id: auto_decompress
    type:
      - 'null'
      - boolean
    doc: Automatically decompress after upload
    inputBinding:
      position: 102
      prefix: --auto-decompress
  - id: dbkey
    type:
      - 'null'
      - string
    doc: Genome Build for dataset
    inputBinding:
      position: 102
      prefix: --dbkey
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug output
    inputBinding:
      position: 102
      prefix: --debug
  - id: file_name
    type:
      - 'null'
      - string
    doc: Filename to use in Galaxy history, if different from path
    inputBinding:
      position: 102
      prefix: --file-name
  - id: file_type
    type:
      - 'null'
      - string
    doc: Galaxy file type to use
    inputBinding:
      position: 102
      prefix: --file-type
  - id: history_id
    type:
      - 'null'
      - string
    doc: Target history ID
    inputBinding:
      position: 102
      prefix: --history-id
  - id: history_name
    type:
      - 'null'
      - string
    doc: Target history name
    inputBinding:
      position: 102
      prefix: --history-name
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Ignore case when matching history names
    inputBinding:
      position: 102
      prefix: --ignore-case
  - id: no_auto_decompress
    type:
      - 'null'
      - boolean
    doc: Do not automatically decompress after upload
    inputBinding:
      position: 102
      prefix: --no-auto-decompress
  - id: no_space_to_tab
    type:
      - 'null'
      - boolean
    doc: Do not convert spaces to tabs
    inputBinding:
      position: 102
      prefix: --no-space-to-tab
  - id: silent
    type:
      - 'null'
      - boolean
    doc: No output while uploading
    inputBinding:
      position: 102
      prefix: --silent
  - id: space_to_tab
    type:
      - 'null'
      - boolean
    doc: Convert spaces to tabs
    inputBinding:
      position: 102
      prefix: --space-to-tab
  - id: storage
    type:
      - 'null'
      - Directory
    doc: Store URLs to resume here
    inputBinding:
      position: 102
      prefix: --storage
  - id: url
    type:
      - 'null'
      - string
    doc: URL of Galaxy instance
    inputBinding:
      position: 102
      prefix: --url
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-upload:1.0.1--pyhdfd78af_0
stdout: galaxy-upload.out
