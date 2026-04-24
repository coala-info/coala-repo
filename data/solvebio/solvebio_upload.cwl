cwlVersion: v1.2
class: CommandLineTool
baseCommand: solvebio upload
label: solvebio_upload
doc: "Upload local files or directories to SolveBio.\n\nTool homepage: https://github.com/solvebio/solvebio-python"
inputs:
  - id: local_path
    type:
      type: array
      items: string
    doc: The path to the local file or directory to upload
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
  - id: archive_folder
    type:
      - 'null'
      - Directory
    doc: Path to archive files that already exist. If a folder is supplied, 
      instead of overwriting or creating an incremented filename, the original 
      remote file will be moved to this archive folder with a timestamp.
    inputBinding:
      position: 102
      prefix: --archive-folder
  - id: create_full_path
    type:
      - 'null'
      - boolean
    doc: 'Creates --full-path location if it does not exist. NOTE: This will not create
      new vaults.'
    inputBinding:
      position: 102
      prefix: --create-full-path
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Dry run mode will not upload any files or create any folders.
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: Paths to files or folder to be excluded from upload. Unix shell-style 
      wildcards are supported.
    inputBinding:
      position: 102
      prefix: --exclude
  - id: follow_shortcuts
    type:
      - 'null'
      - boolean
    doc: Resolves shortcuts when Uploading.
    inputBinding:
      position: 102
      prefix: --follow-shortcuts
  - id: full_path
    type:
      - 'null'
      - string
    doc: The full path where the files and folders should be created, defaults 
      to the root of your personal vault
    inputBinding:
      position: 102
      prefix: --full-path
  - id: max_retries
    type:
      - 'null'
      - int
    doc: Maximum number of retries per upload part for multipart uploads. 
      Defaults to 3.
    inputBinding:
      position: 102
      prefix: --max-retries
  - id: num_processes
    type:
      - 'null'
      - int
    doc: Number of uploads to process in parallel. Defaults to 1, but can be set
      much higher than CPU count since the upload process is IO bound, not CPU 
      bound.
    inputBinding:
      position: 102
      prefix: --num-processes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
stdout: solvebio_upload.out
