cwlVersion: v1.2
class: CommandLineTool
baseCommand: sqlsoup
label: python3-sqlsoup
doc: The provided text does not contain help information for the tool; it is a log
  of a failed container build process. SQLSoup is a library that provides a functional
  interface to SQLAlchemy.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-sqlsoup:v0.9.1-1-deb_cv1
stdout: python3-sqlsoup.out
