cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coreprofiler
  - db
  - download
label: coreprofiler_db_download
doc: "Database download function.\n\nTool homepage: https://gitlab.com/ifb-elixirfr/abromics"
inputs:
  - id: scheme
    type: string
    doc: Scheme name.
    inputBinding:
      position: 101
      prefix: --scheme
  - id: output_dir
    type: string
    doc: Path to store the database.
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: consumer_key
    type:
      - 'null'
      - string
    doc: Consumer key for PUBmlst/BIGSdb API.
    inputBinding:
      position: 101
      prefix: --consumer_key
  - id: consumer_secret
    type:
      - 'null'
      - string
    doc: Consumer secret for PUBmlst/BIGSdb API.
    inputBinding:
      position: 101
      prefix: --consumer_secret
  - id: access_token
    type:
      - 'null'
      - string
    doc: Access token for PUBmlst/BIGSdb API.
    inputBinding:
      position: 101
      prefix: --access_token
  - id: access_secret
    type:
      - 'null'
      - string
    doc: Access token secret for PUBmlst/BIGSdb API.
    inputBinding:
      position: 101
      prefix: --access_secret
  - id: test
    type:
      - 'null'
      - boolean
    doc: Active test mode to limit locus download for schemes to 50.
    inputBinding:
      position: 101
      prefix: --test
outputs:
  - id: database
    type: Directory
    doc: Downloaded scheme database directory.
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreprofiler:2.0.0--pyhdfd78af_0
