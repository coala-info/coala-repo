cwlVersion: v1.2
class: CommandLineTool
baseCommand: biomaj3-cli
label: biomaj3-cli
doc: 'BioMAJ is a workflow engine dedicated to data bank management. (Note: The provided
  text was a system error log and did not contain help documentation for argument
  extraction).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biomaj3-cli:v3.1.10-1-deb-py3_cv1
stdout: biomaj3-cli.out
