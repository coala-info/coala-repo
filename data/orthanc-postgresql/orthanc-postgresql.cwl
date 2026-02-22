cwlVersion: v1.2
class: CommandLineTool
baseCommand: orthanc-postgresql
label: orthanc-postgresql
doc: "Orthanc with PostgreSQL support. Note: The provided text appears to be a container
  build error log rather than CLI help text, so no arguments could be extracted.\n\
  \nTool homepage: https://github.com/markheramis/Orthanc-PostgreSQL"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/orthanc-postgresql:v3.2-1-deb_cv1
stdout: orthanc-postgresql.out
