cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdseq
label: ibdseq
doc: The provided text does not contain help information for ibdseq; it is an error
  message indicating a failure to build the container image due to insufficient disk
  space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdseq:r1206--1
stdout: ibdseq.out
