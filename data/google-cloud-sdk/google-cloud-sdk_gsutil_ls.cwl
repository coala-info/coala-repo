cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gsutil
  - ls
label: google-cloud-sdk_gsutil_ls
doc: "List providers, buckets or objects.\n\nTool homepage: https://cloud.google.com/storage/docs/gsutil"
inputs:
  - id: all_versions
    type:
      - 'null'
      - boolean
    doc: "Includes non-current object versions / generations in the listing."
    inputBinding:
      position: 1
      prefix: -a
  - id: bucket_info
    type:
      - 'null'
      - boolean
    doc: "Prints info about the bucket when used with a bucket URL."
    inputBinding:
      position: 1
      prefix: -b
  - id: dirs_only
    type:
      - 'null'
      - boolean
    doc: "List matching subdirectory names instead of contents, and do not recurse into matching subdirectories."
    inputBinding:
      position: 1
      prefix: -d
  - id: etag
    type:
      - 'null'
      - boolean
    doc: "Include ETag in long listing (-l) output."
    inputBinding:
      position: 1
      prefix: -e
  - id: human_readable
    type:
      - 'null'
      - boolean
    doc: "When used with -l, prints object sizes in human readable format."
    inputBinding:
      position: 1
      prefix: -h
  - id: long_listing
    type:
      - 'null'
      - boolean
    doc: "Prints long listing (owner, length)."
    inputBinding:
      position: 1
      prefix: -l
  - id: long_listing_all
    type:
      - 'null'
      - boolean
    doc: "Prints even more detail than -l."
    inputBinding:
      position: 1
      prefix: -L
  - id: project
    type:
      - 'null'
      - string
    doc: "Specifies the project ID to use for listing buckets."
    inputBinding:
      position: 1
      prefix: -p
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: "Requests a recursive listing."
    inputBinding:
      position: 1
      prefix: -R
  - id: urls
    type:
      type: array
      items: string
    doc: "URLs of providers, buckets or objects to list."
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/google-cloud-sdk:166.0.0--py27_0
stdout: google-cloud-sdk_gsutil_ls.out
