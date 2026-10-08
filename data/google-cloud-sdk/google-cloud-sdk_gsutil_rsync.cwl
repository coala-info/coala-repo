cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gsutil
  - rsync
label: google-cloud-sdk_gsutil_rsync
doc: "Synchronize content of two buckets or directories.\n\nTool homepage: https://cloud.google.com/storage/docs/gsutil"
inputs:
  - id: canned_acl
    type:
      - 'null'
      - string
    doc: "Sets named canned_acl when uploaded objects created."
    inputBinding:
      position: 1
      prefix: -a
  - id: compare_checksums
    type:
      - 'null'
      - boolean
    doc: "Compute and compare checksums instead of mtime."
    inputBinding:
      position: 1
      prefix: -c
  - id: continue_on_error
    type:
      - 'null'
      - boolean
    doc: "If an error occurs, continue to attempt to copy the remaining files."
    inputBinding:
      position: 1
      prefix: -C
  - id: delete_extra
    type:
      - 'null'
      - boolean
    doc: "Delete extra files under dst_url not found under src_url."
    inputBinding:
      position: 1
      prefix: -d
  - id: exclude_symlinks
    type:
      - 'null'
      - boolean
    doc: "Exclude symlinks."
    inputBinding:
      position: 1
      prefix: -e
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: "Dry run: output what would be copied or deleted without doing it."
    inputBinding:
      position: 1
      prefix: -n
  - id: preserve_acl
    type:
      - 'null'
      - boolean
    doc: "Causes ACLs to be preserved when objects are copied."
    inputBinding:
      position: 1
      prefix: -p
  - id: preserve_posix
    type:
      - 'null'
      - boolean
    doc: "Causes POSIX attributes to be preserved when objects are copied."
    inputBinding:
      position: 1
      prefix: -P
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: "Synchronize directories, buckets and bucket subdirectories recursively."
    inputBinding:
      position: 1
      prefix: -R
  - id: skip_unsupported
    type:
      - 'null'
      - boolean
    doc: "Skip objects with unsupported object types instead of failing."
    inputBinding:
      position: 1
      prefix: -U
  - id: exclude_pattern
    type:
      - 'null'
      - string
    doc: "Python regular expression; matching files or objects are excluded."
    inputBinding:
      position: 1
      prefix: -x
  - id: src_url
    type: ['string','Directory']
    doc: "Source directory or bucket URL."
    inputBinding:
      position: 2
  - id: dst_url
    type: string
    doc: "Destination directory or bucket URL."
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: synced_dir
    type:
      - 'null'
      - Directory
    doc: Local destination directory when the destination is a local path.
    outputBinding:
      glob: $(inputs.dst_url)
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: '$(inputs.dst_url.indexOf("gs://") === 0 ? ".gsutil_unused" : inputs.dst_url)'
        entry: '$({"class": "Directory", "basename": "d", "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/google-cloud-sdk:166.0.0--py27_0
stdout: google-cloud-sdk_gsutil_rsync.out
