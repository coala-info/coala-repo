cwlVersion: v1.2
class: CommandLineTool
baseCommand: sqt_docker
label: sqt_docker
doc: "Sequence Toolkit (sqt) containerized via Docker/Apptainer. Note: The provided
  text appears to be a container build log rather than help text, so no arguments
  could be extracted.\n\nTool homepage: https://github.com/tdjsnelling/sqtracker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
stdout: sqt_docker.out
