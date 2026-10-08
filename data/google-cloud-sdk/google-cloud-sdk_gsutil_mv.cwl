cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gsutil
  - mv
label: google-cloud-sdk_gsutil_mv
doc: "Move or rename objects and subdirectories.\n\nTool homepage: https://cloud.google.com/storage/docs/gsutil"
inputs:
  - id: canned_acl
    type:
      - 'null'
      - string
    doc: "Sets named canned_acl when uploaded objects created."
    inputBinding:
      position: 1
      prefix: -a
  - id: all_versions
    type:
      - 'null'
      - boolean
    doc: "Copy all source versions from a source buckets/folders."
    inputBinding:
      position: 1
      prefix: -A
  - id: continue_on_error
    type:
      - 'null'
      - boolean
    doc: "If an error occurs, continue to attempt to copy the remaining files."
    inputBinding:
      position: 1
      prefix: -c
  - id: daisy_chain
    type:
      - 'null'
      - boolean
    doc: "Copy in daisy chain mode."
    inputBinding:
      position: 1
      prefix: -D
  - id: exclude_symlinks
    type:
      - 'null'
      - boolean
    doc: "Exclude symlinks."
    inputBinding:
      position: 1
      prefix: -e
  - id: manifest_log
    type:
      - 'null'
      - string
    doc: "Outputs a manifest log file with detailed information about each item that was copied."
    inputBinding:
      position: 1
      prefix: -L
  - id: no_clobber
    type:
      - 'null'
      - boolean
    doc: "No-clobber: existing files or objects at the destination are not overwritten."
    inputBinding:
      position: 1
      prefix: -n
  - id: preserve_acl
    type:
      - 'null'
      - boolean
    doc: "Causes ACLs to be preserved when copying in the cloud."
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
  - id: storage_class
    type:
      - 'null'
      - string
    doc: "The storage class of the destination object(s)."
    inputBinding:
      position: 1
      prefix: -s
  - id: skip_unsupported
    type:
      - 'null'
      - boolean
    doc: "Skip objects with unsupported object types instead of failing."
    inputBinding:
      position: 1
      prefix: -U
  - id: print_version_url
    type:
      - 'null'
      - boolean
    doc: "Prints the version-specific URL for each uploaded object."
    inputBinding:
      position: 1
      prefix: -v
  - id: gzip_extensions
    type:
      - 'null'
      - string
    doc: "Applies gzip content-encoding to any file upload whose extension matches the comma-separated list."
    inputBinding:
      position: 1
      prefix: -z
  - id: src_urls
    type:
      type: array
      items: 
          - string
          - File
    doc: "Source files or object URLs."
    inputBinding:
      position: 2
  - id: dst_url
    type: string
    doc: "Destination file, directory or object URL."
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: manifest
    type:
      - 'null'
      - File
    doc: Manifest log written with -L.
    outputBinding:
      glob: $(inputs.manifest_log)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/google-cloud-sdk:166.0.0--py27_0
stdout: google-cloud-sdk_gsutil_mv.out
