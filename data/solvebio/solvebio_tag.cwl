cwlVersion: v1.2
class: CommandLineTool
baseCommand: solvebio tag
label: solvebio_tag
doc: "Apply tag updates to files, folders, or datasets.\n\nTool homepage: https://github.com/solvebio/solvebio-python"
inputs:
  - id: full_path
    type:
      type: array
      items: string
    doc: The full path of the files, folders or datasets to apply the tag 
      updates. Unix shell-style wildcards are supported.
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
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Dry run mode will not save tags.
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: exclude
    type:
      - 'null'
      - string
    doc: Paths to files or folder to be excluded from tagging. Unix shell-style 
      wildcards are supported.
    inputBinding:
      position: 102
      prefix: --exclude
  - id: no_input
    type:
      - 'null'
      - boolean
    doc: Automatically accept changes (overrides user prompt)
    inputBinding:
      position: 102
      prefix: --no-input
  - id: remove
    type:
      - 'null'
      - boolean
    doc: Will remove tags instead of adding them.
    inputBinding:
      position: 102
      prefix: --remove
  - id: tag
    type: string
    doc: 'A tag to be added/removed. Files, folders and datasets can be tagged. Tags
      are case insensitive strings. Example tags: --tag GRCh38 --tag Tissue --tag
      "Foundation Medicine"'
    inputBinding:
      position: 102
      prefix: --tag
  - id: tag_datasets_only
    type:
      - 'null'
      - boolean
    doc: Will only apply tags to datasets (tags all objects by default).
    inputBinding:
      position: 102
      prefix: --tag-datasets-only
  - id: tag_files_only
    type:
      - 'null'
      - boolean
    doc: Will only apply tags to files (tags all objects by default).
    inputBinding:
      position: 102
      prefix: --tag-files-only
  - id: tag_folders_only
    type:
      - 'null'
      - boolean
    doc: Will only apply tags to folders (tags all objects by default).
    inputBinding:
      position: 102
      prefix: --tag-folders-only
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
stdout: solvebio_tag.out
