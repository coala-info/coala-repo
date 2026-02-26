cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsrq purge
label: rsrq_purge
doc: "Removes all data from Redis\n\nTool homepage: https://github.com/aaronmussig/rsrq"
inputs:
  - id: command
    type: string
    doc: The specific purge command to execute (all, failed, finished, queued)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
stdout: rsrq_purge.out
