cwlVersion: v1.2
class: CommandLineTool
baseCommand: dazz_db
label: dazz_db
doc: "The provided text is a system error log regarding a container build failure
  and does not contain help documentation or command-line arguments for the tool.\n
  \nTool homepage: https://github.com/thegenemyers/DAZZ_DB"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dazz_db:1.0--0
stdout: dazz_db.out
