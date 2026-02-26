cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bpipe
  - jobs
label: bpipe_jobs
doc: "List and manage Bpipe jobs\n\nTool homepage: http://docs.bpipe.org/"
inputs:
  - id: show_all
    type:
      - 'null'
      - boolean
    doc: Show completed  as well as running jobs
    inputBinding:
      position: 101
      prefix: -all
  - id: sleep_time
    type:
      - 'null'
      - string
    doc: Sleep time when watching continuously
    inputBinding:
      position: 101
      prefix: -sleep
  - id: watch
    type:
      - 'null'
      - boolean
    doc: Show continuously updated display
    inputBinding:
      position: 101
      prefix: -watch
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
stdout: bpipe_jobs.out
