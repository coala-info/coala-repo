cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsrq status
label: rsrq_status
doc: "Check the status of all objects in the Redis database\n\nTool homepage: https://github.com/aaronmussig/rsrq"
inputs:
  - id: queue
    type:
      - 'null'
      - string
    doc: The target queue to check
    inputBinding:
      position: 101
      prefix: --queue
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
stdout: rsrq_status.out
