cwlVersion: v1.2
class: CommandLineTool
baseCommand: solvebio download
label: solvebio_download
doc: "Downloads files from SolveBio.\n\nTool homepage: https://github.com/solvebio/solvebio-python"
inputs:
  - id: full_path
    type: string
    doc: "The full path to the files on SolveBio. Supports Unix\n                \
      \        style globs in order to download multiple files. Note:\n          \
      \              Downloads are not recursive unless --recursive flag is\n    \
      \                    used."
    inputBinding:
      position: 1
  - id: local_path
    type: Directory
    doc: "The path to the local directory where to download\n                    \
      \    files."
    inputBinding:
      position: 2
  - id: access_token
    type:
      - 'null'
      - string
    doc: Manually provide a SolveBio OAuth2 access token
    inputBinding:
      position: 103
      prefix: --access-token
  - id: api_host
    type:
      - 'null'
      - string
    doc: Override the default SolveBio API host
    inputBinding:
      position: 103
      prefix: --api-host
  - id: api_key
    type:
      - 'null'
      - string
    doc: Manually provide a SolveBio API key
    inputBinding:
      position: 103
      prefix: --api-key
  - id: delete
    type:
      - 'null'
      - boolean
    doc: "Deletes local files not found in remote full path.\n                   \
      \     Warning, this is dangerous and will delete any files\n               \
      \         found in local path. Do not use a top-level local path\n         \
      \               such as \"/\" and always use the --dry-run mode to\n       \
      \                 evaluate any changes. Empty folders will be deleted."
    inputBinding:
      position: 103
      prefix: --delete
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: "Dry run mode will not download any files or create any\n               \
      \         folders. Use this mode before using the --delete flag."
    inputBinding:
      position: 103
      prefix: --dry-run
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: "Pattern to match against local full paths of files to\n                \
      \        be excluded from downloading. This pattern is only\n              \
      \          used when --recursive is used. Unix shell-style\n               \
      \         wildcards are supported. Exclude patterns will always\n          \
      \              be superseded by include patterns."
    inputBinding:
      position: 103
      prefix: --exclude
  - id: follow_shortcuts
    type:
      - 'null'
      - boolean
    doc: "Resolves shortcuts when downloading. If a shortcut to\n                \
      \        a file is found the target file will be downloaded\n              \
      \          under the shortcut name."
    inputBinding:
      position: 103
      prefix: --follow-shortcuts
  - id: include
    type:
      - 'null'
      - type: array
        items: string
    doc: "Pattern to match against full paths of files to be\n                   \
      \     included for downloading. This pattern is only used\n                \
      \        when --recursive is used. Unix shell-style wildcards\n            \
      \            are supported. Include patterns will always supersede\n       \
      \                 exclude patterns."
    inputBinding:
      position: 103
      prefix: --include
  - id: num_processes
    type:
      - 'null'
      - int
    doc: "Number of downloads to process in parallel. If not\n                   \
      \     specified downloads won't be executed in parallel.If a\n             \
      \           number less than 1 is set defaults to the number of\n          \
      \              system CPUs."
    inputBinding:
      position: 103
      prefix: --num-processes
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: "Downloads files recursively. Note that empty folders\n                 \
      \       will be ignored."
    inputBinding:
      position: 103
      prefix: --recursive
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/solvebio:2.34.0--pyh7e72e81_0
stdout: solvebio_download.out
