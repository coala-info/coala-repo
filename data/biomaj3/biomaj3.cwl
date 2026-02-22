cwlVersion: v1.2
class: CommandLineTool
baseCommand: biomaj3
label: biomaj3
doc: "BioMAJ is a workflow engine dedicated to data bank management. (Note: The provided
  text contains system error messages regarding disk space and container execution
  rather than command-line help documentation.)\n\nTool homepage: https://github.com/horkko/biomaj-postgres"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biomaj3:v3.1.6-1-deb-py3_cv1
stdout: biomaj3.out
