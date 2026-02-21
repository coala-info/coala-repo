cwlVersion: v1.2
class: CommandLineTool
baseCommand: dialign-tx-data
label: dialign-tx-data
doc: Data component for DIALIGN-TX, a segment-based multiple sequence alignment tool.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dialign-tx-data:v1.0.2-12-deb_cv1
stdout: dialign-tx-data.out
