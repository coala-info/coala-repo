cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsutil
label: google-cloud-sdk_gsutil
doc: "Google Cloud Storage utility\n\nTool homepage: https://cloud.google.com/sdk/"
inputs:
  - id: command
    type: string
    doc: The command to execute
    inputBinding:
      position: 1
  - id: command_opts
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the command
    inputBinding:
      position: 2
  - id: command_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 3
  - id: debug_level_d
    type:
      - 'null'
      - boolean
    doc: Enable debug output
    inputBinding:
      position: 104
      prefix: -D
  - id: debug_level_dd
    type:
      - 'null'
      - boolean
    doc: Enable more verbose debug output
    inputBinding:
      position: 104
      prefix: -DD
  - id: header
    type:
      - 'null'
      - type: array
        items: string
    doc: Header to include in requests
    inputBinding:
      position: 104
      prefix: -h
  - id: multithreaded
    type:
      - 'null'
      - boolean
    doc: Enable multithreaded operations
    inputBinding:
      position: 104
      prefix: -m
  - id: parallel_uploads
    type:
      - 'null'
      - boolean
    doc: Enable parallel uploads
    inputBinding:
      position: 104
      prefix: -o
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress non-essential output
    inputBinding:
      position: 104
      prefix: -q
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/google-cloud-sdk:166.0.0--py27_0
stdout: google-cloud-sdk_gsutil.out
