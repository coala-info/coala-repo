cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gsutil
  - du
label: google-cloud-sdk_gsutil_du
doc: "Display object size usage.\n\nTool homepage: https://cloud.google.com/storage/docs/gsutil"
inputs:
  - id: null_terminated
    type:
      - 'null'
      - boolean
    doc: "Ends each output line with a 0 byte rather than a newline."
    inputBinding:
      position: 1
      prefix: '-0'
  - id: all_versions
    type:
      - 'null'
      - boolean
    doc: "Includes non-current object versions / generations in the listing."
    inputBinding:
      position: 1
      prefix: -a
  - id: total
    type:
      - 'null'
      - boolean
    doc: "Includes a grand total at the end of the output."
    inputBinding:
      position: 1
      prefix: -c
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -e
    doc: "A pattern to exclude from reporting. Can be given several times."
    inputBinding:
      position: 1
  - id: human_readable
    type:
      - 'null'
      - boolean
    doc: "Prints object sizes in human-readable format."
    inputBinding:
      position: 1
      prefix: -h
  - id: summarize
    type:
      - 'null'
      - boolean
    doc: "Displays only the grand total for each argument."
    inputBinding:
      position: 1
      prefix: -s
  - id: exclude_file
    type:
      - 'null'
      - File
    doc: "File with patterns to exclude, one per line."
    inputBinding:
      position: 1
      prefix: -X
  - id: urls
    type:
      type: array
      items: string
    doc: "Bucket or object URLs to measure."
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
stdout: google-cloud-sdk_gsutil_du.out
