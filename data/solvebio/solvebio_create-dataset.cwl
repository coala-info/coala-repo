cwlVersion: v1.2
class: CommandLineTool
baseCommand: solvebio create-dataset
label: solvebio_create-dataset
doc: "Create a new dataset\n\nTool homepage: https://github.com/solvebio/solvebio-python"
inputs:
  - id: full_path
    type: string
    doc: 'The full path to the dataset in the format: "domain:vault:/path/dataset".
      Defaults to your personal vault if no vault is provided. Defaults to the vault
      root if no path is provided.'
    inputBinding:
      position: 1
  - id: access_token
    type:
      - 'null'
      - string
    doc: Manually provide a SolveBio OAuth2 access token
    inputBinding:
      position: 102
      prefix: --access-token
  - id: api_host
    type:
      - 'null'
      - string
    doc: Override the default SolveBio API host
    inputBinding:
      position: 102
      prefix: --api-host
  - id: api_key
    type:
      - 'null'
      - string
    doc: Manually provide a SolveBio API key
    inputBinding:
      position: 102
      prefix: --api-key
  - id: capacity
    type:
      - 'null'
      - string
    doc: 'Specifies the capacity of the dataset: small (default, <100M records), medium
      (<500M), large (>=500M)'
    inputBinding:
      position: 102
      prefix: --capacity
  - id: create_vault
    type:
      - 'null'
      - boolean
    doc: Create the vault if it doesn't exist
    inputBinding:
      position: 102
      prefix: --create-vault
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Dry run mode will not create the dataset
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: metadata
    type:
      - 'null'
      - type: array
        items: string
    doc: Dataset metadata in the format KEY=VALUE
    inputBinding:
      position: 102
      prefix: --metadata
  - id: metadata_json_file
    type:
      - 'null'
      - File
    doc: Metadata key value pairs in JSON format
    inputBinding:
      position: 102
      prefix: --metadata-json-file
  - id: tag
    type:
      - 'null'
      - type: array
        items: string
    doc: 'A tag to be added. Tags are case insensitive strings. Example tags: --tag
      GRCh38 --tag Tissue --tag "Foundation Medicine"'
    inputBinding:
      position: 102
      prefix: --tag
  - id: template_file
    type:
      - 'null'
      - File
    doc: A local template file to be used when creating a new dataset (via 
      --create-dataset)
    inputBinding:
      position: 102
      prefix: --template-file
  - id: template_id
    type:
      - 'null'
      - string
    doc: The template ID used when creating a new dataset (via --create-dataset)
    inputBinding:
      position: 102
      prefix: --template-id
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
stdout: solvebio_create-dataset.out
