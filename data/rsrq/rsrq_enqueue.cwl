cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rsrq
  - enqueue
label: rsrq_enqueue
doc: "Enqueue a batch of commands to be run\n\nTool homepage: https://github.com/aaronmussig/rsrq"
inputs:
  - id: queue
    type: string
    doc: The target queue to add jobs to
    inputBinding:
      position: 1
  - id: path
    type: File
    doc: Path to the file containing one command per-line
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
stdout: rsrq_enqueue.out
