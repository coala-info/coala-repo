cwlVersion: v1.2
class: CommandLineTool
baseCommand: sqlsoup
label: sqlsoup
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/kenwilcox/sqlsoup"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sqlsoup:v0.9.1-3-deb-py3_cv1
stdout: sqlsoup.out
