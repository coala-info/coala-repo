cwlVersion: v1.2
class: CommandLineTool
baseCommand: arv-put
label: arvados-python-client_arv-put
doc: "Copy data from the local filesystem to Keep.\n\nTool homepage: https://github.com/curoverse/arvados/tree/main/sdk/python"
inputs:
  - id: path
    type:
      - 'null'
      - type: array
        items: File
    doc: "Local file or directory. If path is a directory reference with a trailing
      slash, then just upload the directory's contents; otherwise upload the directory
      itself. Default: read from standard input."
    inputBinding:
      position: 1
  - id: as_manifest
    type:
      - 'null'
      - boolean
    doc: Synonym for --manifest.
    inputBinding:
      position: 102
      prefix: --as-manifest
  - id: as_raw
    type:
      - 'null'
      - boolean
    doc: Synonym for --raw.
    inputBinding:
      position: 102
      prefix: --as-raw
  - id: as_stream
    type:
      - 'null'
      - boolean
    doc: Synonym for --stream.
    inputBinding:
      position: 102
      prefix: --as-stream
  - id: batch
    type:
      - 'null'
      - boolean
    doc: Retries with '--no-resume --no-cache' if cached state contains invalid/expired
      block signatures.
    inputBinding:
      position: 102
      prefix: --batch
  - id: batch_progress
    type:
      - 'null'
      - boolean
    doc: Display machine-readable progress on stderr (bytes and, if known, total data
      size).
    inputBinding:
      position: 102
      prefix: --batch-progress
  - id: cache
    type:
      - 'null'
      - boolean
    doc: Save upload state in a cache file for resuming (default).
    inputBinding:
      position: 102
      prefix: --cache
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Don't actually upload files, but only check if any file should be uploaded.
      Exit with code=2 when files are pending for upload.
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: Exclude files and directories whose names match the given glob pattern. You
      can specify multiple patterns by using this argument more than once.
    inputBinding:
      position: 102
      prefix: --exclude
  - id: filename
    type:
      - 'null'
      - string
    doc: Use the given filename in the manifest, instead of the name of the local
      file. This is useful when "-" or "/dev/stdin" is given as an input file. It
      can be used only if there is exactly one path given and it is not a directory.
      Implies --manifest.
    inputBinding:
      position: 102
      prefix: --filename
  - id: follow_links
    type:
      - 'null'
      - boolean
    doc: Follow file and directory symlinks (default).
    inputBinding:
      position: 102
      prefix: --follow-links
  - id: in_manifest
    type:
      - 'null'
      - boolean
    doc: Synonym for --manifest.
    inputBinding:
      position: 102
      prefix: --in-manifest
  - id: manifest
    type:
      - 'null'
      - boolean
    doc: Store the file data and resulting manifest in Keep, save a Collection object
      in Arvados, and display the manifest locator (Collection uuid) on stdout. This
      is the default behavior.
    inputBinding:
      position: 102
      prefix: --manifest
  - id: name
    type:
      - 'null'
      - string
    doc: Save the collection with the specified name.
    inputBinding:
      position: 102
      prefix: --name
  - id: no_cache
    type:
      - 'null'
      - boolean
    doc: Do not save upload state in a cache file for resuming.
    inputBinding:
      position: 102
      prefix: --no-cache
  - id: no_follow_links
    type:
      - 'null'
      - boolean
    doc: Ignore file and directory symlinks. Even paths given explicitly on the command
      line will be skipped if they are symlinks.
    inputBinding:
      position: 102
      prefix: --no-follow-links
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Do not display human-readable progress on stderr, even if stderr is a tty.
    inputBinding:
      position: 102
      prefix: --no-progress
  - id: no_resume
    type:
      - 'null'
      - boolean
    doc: Do not continue interrupted uploads from cached state.
    inputBinding:
      position: 102
      prefix: --no-resume
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Normalize the manifest by re-ordering files and streams after writing data.
    inputBinding:
      position: 102
      prefix: --normalize
  - id: portable_data_hash
    type:
      - 'null'
      - boolean
    doc: Print the portable data hash instead of the Arvados UUID for the collection
      created by the upload.
    inputBinding:
      position: 102
      prefix: --portable-data-hash
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Display human-readable progress on stderr (bytes and, if possible, percentage
      of total data size). This is the default behavior when stderr is a tty.
    inputBinding:
      position: 102
      prefix: --progress
  - id: project_uuid
    type:
      - 'null'
      - string
    doc: Store the collection in the specified project, instead of your Home project.
    inputBinding:
      position: 102
      prefix: --project-uuid
  - id: raw
    type:
      - 'null'
      - boolean
    doc: Store the file content and display the data block locators on stdout, separated
      by commas, with a trailing newline. Do not store a manifest.
    inputBinding:
      position: 102
      prefix: --raw
  - id: replication
    type:
      - 'null'
      - int
    doc: 'Set the replication level for the new collection: how many different physical
      storage devices (e.g., disks) should have a copy of each data block. Default
      is to use the server-provided default (if any) or 2.'
    inputBinding:
      position: 102
      prefix: --replication
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Continue interrupted uploads from cached state (default).
    inputBinding:
      position: 102
      prefix: --resume
  - id: retries
    type:
      - 'null'
      - int
    doc: Maximum number of times to retry server requests that encounter temporary
      failures (e.g., server down). Default 10.
    inputBinding:
      position: 102
      prefix: --retries
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Do not print any debug messages to console. (Any error messages will still
      be displayed.)
    inputBinding:
      position: 102
      prefix: --silent
  - id: storage_classes
    type:
      - 'null'
      - string
    doc: Specify comma separated list of storage classes to be used when saving data
      to Keep.
    inputBinding:
      position: 102
      prefix: --storage-classes
  - id: stream
    type:
      - 'null'
      - boolean
    doc: Store the file content and display the resulting manifest on stdout. Do not
      save a Collection object in Arvados.
    inputBinding:
      position: 102
      prefix: --stream
  - id: threads
    type:
      - 'null'
      - int
    doc: Set the number of upload threads to be used. Take into account that using
      lots of threads will increase the RAM requirements. Default is to use 2 threads.
      On high latency installations, using a greater number will improve overall throughput.
    inputBinding:
      position: 102
      prefix: --threads
  - id: trash_after
    type:
      - 'null'
      - int
    doc: Set the trash date of the resulting collection to an amount of days from
      the date/time that the upload process finishes.
    inputBinding:
      position: 102
      prefix: --trash-after
  - id: trash_at
    type:
      - 'null'
      - string
    doc: Set the trash date of the resulting collection to an absolute date in the
      future. The accepted format is defined by the ISO 8601 standard.
    inputBinding:
      position: 102
      prefix: --trash-at
  - id: update_collection
    type:
      - 'null'
      - string
    doc: Update an existing collection identified by the given Arvados collection
      UUID. All new local files will be uploaded.
    inputBinding:
      position: 102
      prefix: --update-collection
  - id: use_filename
    type:
      - 'null'
      - string
    doc: Synonym for --filename.
    inputBinding:
      position: 102
      prefix: --use-filename
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arvados-python-client:3.2.0--pyh7e72e81_0
stdout: arvados-python-client_arv-put.out
