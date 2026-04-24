cwlVersion: v1.2
class: CommandLineTool
baseCommand: arv-get
label: arvados-python-client_arv-get
doc: "Copy data from Keep to a local file or pipe.\n\nTool homepage: https://github.com/curoverse/arvados/tree/main/sdk/python"
inputs:
  - id: locator
    type: string
    doc: Collection locator, optionally with a file path or prefix.
    inputBinding:
      position: 1
  - id: batch_progress
    type:
      - 'null'
      - boolean
    doc: Display machine-readable progress on stderr.
    inputBinding:
      position: 102
      prefix: --batch-progress
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Do not write any data -- just read from Keep, and report md5sums if requested.
    inputBinding:
      position: 102
      prefix: -n
  - id: hash
    type:
      - 'null'
      - string
    doc: Display the hash of each file as it is read from Keep, using the given hash
      algorithm. Supported algorithms include md5, sha1, sha224, sha256, sha384, and
      sha512.
    inputBinding:
      position: 102
      prefix: --hash
  - id: md5sum
    type:
      - 'null'
      - boolean
    doc: Display the MD5 hash of each file as it is read from Keep.
    inputBinding:
      position: 102
      prefix: --md5sum
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Do not display human-readable progress on stderr.
    inputBinding:
      position: 102
      prefix: --no-progress
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files while writing.
    inputBinding:
      position: 102
      prefix: -f
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Display human-readable progress on stderr.
    inputBinding:
      position: 102
      prefix: --progress
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Retrieve all files in the specified collection/prefix.
    inputBinding:
      position: 102
      prefix: -r
  - id: retries
    type:
      - 'null'
      - int
    doc: Maximum number of times to retry server requests that encounter temporary
      failures (e.g., server down).
    inputBinding:
      position: 102
      prefix: --retries
  - id: skip_existing
    type:
      - 'null'
      - boolean
    doc: Skip files that already exist.
    inputBinding:
      position: 102
      prefix: --skip-existing
  - id: strip_manifest
    type:
      - 'null'
      - boolean
    doc: When getting a collection manifest, strip its access tokens before writing
      it.
    inputBinding:
      position: 102
      prefix: --strip-manifest
  - id: threads
    type:
      - 'null'
      - int
    doc: Set the number of download threads to be used.
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Once for verbose mode, twice for debug mode.
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: destination
    type:
      - 'null'
      - File
    doc: 'Local file or directory where the data is to be written. Default: stdout.'
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arvados-python-client:3.2.0--pyh7e72e81_0
