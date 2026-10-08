cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gsutil
  - cat
label: google-cloud-sdk_gsutil_cat
doc: "Concatenate object content to standard output.\n\nTool homepage: https://cloud.google.com/storage/docs/gsutil"
inputs:
  - id: header
    type:
      - 'null'
      - boolean
    doc: "Prints short header for each object."
    inputBinding:
      position: 1
      prefix: -h
  - id: range
    type:
      - 'null'
      - string
    doc: "Output just the specified byte range of the object (start-end, start- or -numbytes)."
    inputBinding:
      position: 1
      prefix: -r
  - id: urls
    type:
      type: array
      items: string
    doc: "Object URLs (gs://bucket/object) to print."
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
stdout: google-cloud-sdk_gsutil_cat.out
