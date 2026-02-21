cwlVersion: v1.2
class: CommandLineTool
baseCommand: filo_cqlsh
label: filo_cqlsh
doc: "A tool for interacting with FiloDB using CQL (Cassandra Query Language). Note:
  The provided help text contains only system error logs and does not list available
  command-line arguments.\n\nTool homepage: https://github.com/filodb/FiloDB"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/filo:v1.1.0-3b1-deb_cv1
stdout: filo_cqlsh.out
