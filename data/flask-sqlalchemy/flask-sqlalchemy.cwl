cwlVersion: v1.2
class: CommandLineTool
baseCommand: flask-sqlalchemy
label: flask-sqlalchemy
doc: "Flask-SQLAlchemy (Note: The provided text is an error log indicating the executable
  was not found and does not contain help documentation or argument definitions.)\n
  \nTool homepage: https://github.com/pallets-eco/flask-sqlalchemy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flask-sqlalchemy:2.1--py36_0
stdout: flask-sqlalchemy.out
