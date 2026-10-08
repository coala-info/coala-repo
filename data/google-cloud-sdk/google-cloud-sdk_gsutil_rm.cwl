cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gsutil
  - rm
label: google-cloud-sdk_gsutil_rm
doc: "Remove objects.\n\nTool homepage: https://cloud.google.com/storage/docs/gsutil"
inputs:
  - id: continue_silently
    type:
      - 'null'
      - boolean
    doc: "Continues silently despite errors when removing multiple objects."
    inputBinding:
      position: 1
      prefix: -f
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: "Remove bucket or bucket subdirectory contents recursively."
    inputBinding:
      position: 1
      prefix: -R
  - id: all_versions
    type:
      - 'null'
      - boolean
    doc: "Delete all versions of an object."
    inputBinding:
      position: 1
      prefix: -a
  - id: urls
    type:
      type: array
      items: string
    doc: "Object or bucket URLs to remove."
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
stdout: google-cloud-sdk_gsutil_rm.out
