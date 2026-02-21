cwlVersion: v1.2
class: CommandLineTool
baseCommand: sqlalchemy-utils
label: sqlalchemy-utils
doc: "The provided text does not contain help information or documentation for the
  tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/kvesteri/sqlalchemy-utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sqlalchemy-utils:0.31.6--py36_0
stdout: sqlalchemy-utils.out
