cwlVersion: v1.2
class: CommandLineTool
baseCommand: flask-potion
label: flask-potion
doc: "Flask-Potion is a RESTful API framework for Flask and SQLAlchemy, Peewee or
  MongoEngine.\n\nTool homepage: https://github.com/biosustain/potion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flask-potion:0.12.1--py35_0
stdout: flask-potion.out
