cwlVersion: v1.2
class: CommandLineTool
baseCommand: orthanc-mysql
label: orthanc-mysql
doc: "Orthanc with MySQL support. Note: The provided help text contains only system
  error messages regarding a failed container build and does not list the tool's command-line
  arguments.\n\nTool homepage: https://github.com/devhliu/GaelO_Installation"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/orthanc-mysql:v2.0-2-deb_cv1
stdout: orthanc-mysql.out
