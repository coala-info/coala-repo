cwlVersion: v1.2
class: CommandLineTool
baseCommand: mysql-connector-c
label: mysql-connector-c
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or command-line arguments for the tool.\n\n
  Tool homepage: https://github.com/mysql-net/MySqlConnector"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mysql-connector-c:6.1.6--2
stdout: mysql-connector-c.out
