cwlVersion: v1.2
class: CommandLineTool
baseCommand: touch
label: drive_touch
doc: "Touch files with specified modification times.\n\nTool homepage: https://github.com/kamranahmedse/driver.js"
inputs:
  - id: depth
    type:
      - 'null'
      - int
    doc: max traversal depth
    default: -1
    inputBinding:
      position: 101
      prefix: -depth
  - id: duration
    type:
      - 'null'
      - string
    doc: "the duration offset from now that each file's modification time should be
      set to e.g -32h\nSee https://golang.org/pkg/time/#ParseDuration"
    inputBinding:
      position: 101
      prefix: -duration
  - id: format
    type:
      - 'null'
      - string
    doc: "the custom layout that you'd like your time to be set in, representative
      of the way 'Mon Jan 2 15:04:05 -0700 MST 2006' should be represented\nSee https://golang.org/pkg/time/#Parse"
    default: '20060102150405'
    inputBinding:
      position: 101
      prefix: -format
  - id: hidden
    type:
      - 'null'
      - boolean
    doc: allows pushing of hidden paths
    inputBinding:
      position: 101
      prefix: -hidden
  - id: id
    type:
      - 'null'
      - boolean
    doc: share by id instead of path
    inputBinding:
      position: 101
      prefix: -id
  - id: matches
    type:
      - 'null'
      - boolean
    doc: search by prefix and touch
    inputBinding:
      position: 101
      prefix: -matches
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: if set, do not log anything but errors
    inputBinding:
      position: 101
      prefix: -quiet
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: toggles recursive touching
    inputBinding:
      position: 101
      prefix: -recursive
  - id: time
    type:
      - 'null'
      - string
    doc: the time each file's modification time should be set to
    inputBinding:
      position: 101
      prefix: -time
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show step by step information verbosely
    default: true
    inputBinding:
      position: 101
      prefix: -verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drive:0.3.9--0
stdout: drive_touch.out
